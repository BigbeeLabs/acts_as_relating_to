module BigbeeLabs::ActsAs::Calling::Services

  module ClassMethods
    
  end
  
  module InstanceMethods

  private

    def caller
      self 
    end

    def call_service(service, options={})
      service.call((build_service_details(service) || {}).merge!(options))
    end
  
    def build_service_details(service_to_call)
      if build_service_to_call_details?(service_to_call)
        returning = {}.with_indifferent_access
        process_details_ary(service_to_call::SERVICE_DETAILS, returning)
        returning
      end
    end

    def build_service_to_call_details?(service_to_call)
      service_to_call && defined?(service_to_call::SERVICE_DETAILS)
    end

    def process_details_sym(method_sym, returning, prefix=nil)
      method_to_send = prefix ? "#{prefix}_#{method_sym}".to_sym : method_sym
      returning[method_sym] = send(method_to_send)
      returning
    end

    def process_details_hsh(hsh, returning, prefix=nil)
      hsh.each do |k,v|
        returning[k] = process_details_ary(v, {}.with_indifferent_access, k) if v.is_a?(Array)
        returning[k] = process_details_sym(v, returning, k) if v.is_a?(Symbol)
      end
      returning
    end

    def process_details_ary(ary, returning, prefix=nil)
      ary.each do |detail_key|
        process_details_sym(detail_key, returning, prefix) if detail_key.is_a?(Symbol)
        process_details_hsh(detail_key, returning, prefix) if detail_key.is_a?(Hash)
      end
      returning
    end
    
  end
  
  def self.included(receiver)
    receiver.extend  ClassMethods
    receiver.include InstanceMethods
  end
end