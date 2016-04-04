module ActsAsRelatingTo
  module DefineMethods
    module DropRelationshipToThingRemote
      
      def define_method_drop_relationship_to_thing_remote(class_sym, options={})
        thing_klass_name = options[:class_name]
        thing_klass_name ||= class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize
        thing_objekt_name = class_sym.to_s.singularize

        define_method("drop_relationship_to_#{thing_objekt_name}_url") do
          my_klass.url = self.class::APP_PROVIDER.url
          my_klass.url = "#{url}/#{my_object_name.pluralize}/#{self.id}"
          my_klass.url = "#{url}/#{class_sym}/#{@thing.id}"
        end

        define_method("drop_relationship_to_#{thing_objekt_name}") do |thing|
          if thing.is_a?(thing_klass)
            @thing = thing
            my_klass.called_by = "drop_relationship_to_#{thing_objekt_name}"
            result = generic('delete')
            remove_instance_variable(:@thing)
            result.with_indifferent_access
          else
            raise "in #{my_klass}.#{__method__}, expected a #{thing_klass_name}, but got a #{thing.class.name}"
          end
        end



      end # define_method_drop_relationship_to_thing_remote

    end
  end
end