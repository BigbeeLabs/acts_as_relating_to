module ActsAsRelatingTo
  module DefineMethods
    module ThingsIRelateToRemote
      def define_method_things_i_relate_to_remote(class_sym, options={})
        thing_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize

        define_method("#{class_sym.to_s}_i_relate_to_url") do |options={}|
          @url = app_provider.url.clone
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/things_i_relate_to"
          append_query
        end

        define_method("#{class_sym.to_s}_i_relate_to") do |options={}|
          @called_by = __method__.to_s
          @query = options
          @query[:thing_type] = class_sym.to_s
          generic('get').tap do |remote_result|
            @called_by = nil
            @query = nil
            @url = nil
            remote_result = JSON.parse(remote_result) if remote_result.is_a?(String)
            return remote_result.map{|thing_hsh| thing_klass.new(thing_hsh)}
          end
        end

      end
    end
  end
end