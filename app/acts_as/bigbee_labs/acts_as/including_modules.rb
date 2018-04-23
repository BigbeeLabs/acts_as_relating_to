module BigbeeLabs::ActsAs::IncludingModules
  module ClassMethods
    
    def include_modules(args=nil)
      @module_name_ary = []
      do_hash(args) if args.is_a?(Hash)
      @module_name_ary = nil
    end

  private

    def do_hash(args)
      args.each do |k,v|
        @module_name_ary << k.to_s.camelize
        do_hash(v) if v.is_a?(Hash)
        do_ary(v) if v.is_a?(Array)
        @module_name_ary.pop
      end
    end

    def do_ary(args)
      args.each do |arg|
        do_sym(arg) if arg.is_a?(Symbol)
      end
    end

    def do_sym(arg)
      @module_name_ary << arg.to_s.camelize 
      @module_name_ary.clone.join('::').tap do |module_name|
        include module_name.constantize
      end
      @module_name_ary.pop
    end

  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend  ClassMethods
    receiver.include InstanceMethods
  end
end