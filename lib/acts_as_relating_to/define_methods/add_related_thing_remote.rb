module ActsAsRelatingTo
  module DefineMethods
    module AddRelatedThingRemote
      def define_method_add_related_thing_remote(class_sym, options={})
        thing_objekt_name = class_sym.to_s.singularize

        define_method("add_#{thing_objekt_name}_url") do 
          my_klass.url = "#{my_klass.app_provider.url}"
          my_klass.url = "#{my_klass.url}/#{my_object_name.pluralize}/#{self.id}"
          my_klass.url = "#{my_klass.url}/enrolled_programs/#{@thing.id}"
        end

        define_method("add_#{thing_objekt_name}") do |thing|
          @thing = thing
          my_klass.called_by = "add_#{thing_objekt_name}"
          res = generic('put')
          remove_instance_variable(:@thing)
          res
        end

        private "add_#{thing_objekt_name}_url".to_sym
        
      end
    end
  end
end