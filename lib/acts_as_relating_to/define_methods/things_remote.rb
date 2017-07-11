module ActsAsRelatingTo
  module DefineMethods
    module ThingsRemote
      def things_remote(class_sym, options={})
        things_klass_name = options[:class_name]
        things_klass_name ||= class_sym.to_s.singularize.camelize 
        thing_objekt_name = options[:class_name].demodulize.underscore if options[:class_name]
        thing_objekt_name ||= class_sym.to_s.singularize
        thing_klass = things_klass_name.constantize

        define_method("#{class_sym}_url") do
          my_klass.url = "#{my_klass.app_provider.url}/#{my_object_name.pluralize}/#{self.id}/#{class_sym}"
          append_query(thing_objekt_name)
        end

        define_method(class_sym) do |args={}|
          my_klass.query = args unless args.empty?
          my_klass.called_by = class_sym.to_s
          return make_collection(generic('get'))
        end

        define_method :make_collection do |results|
          if results.is_a?(Array)
            ret = []
            results.each do |result|
              ret << thing_klass.new(result)
            end
            return ret
          else
            return results
          end
        end

        private "#{class_sym}".to_sym
        private "#{class_sym}_url".to_sym
        private :make_collection


      end
    end
  end
end