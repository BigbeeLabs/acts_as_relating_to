module ActsAsRelatingTo
  module DefineMethods
    module ThingsRemote
      def things_remote(class_sym, options={})
        things_klass_name = options[:class_name]
        things_klass_name ||= class_sym.to_s.singularize.camelize 
        thing_objekt_name = options[:class_name].demodulize.underscore if options[:class_name]
        thing_objekt_name ||= class_sym.to_s.singularize

        define_method("#{class_sym}_url") do
          my_klass.url = "#{self.class::APP_PROVIDER.url}/#{my_object_name}/#{self.id}/#{class_sym}"
          append_query(thing_objekt_name)
        end

        define_method(class_sym) do |args={}|
          my_klass.query = args
          my_klass.called_by = class_sym.to_s
          res = generic('get')
        end

      end
    end
  end
end