module ActsAsRelatingTo
  module DefineMethods
    module DropRelationshipToThingLocal
      
      def define_method_drop_relationship_to_thing_local(class_sym, options={})
        thing_klass_name = options[:class_name]
        thing_klass_name ||= class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize
        thing_object_name = options[:class_name].demodulize.underscore if options[:class_name]
        thing_object_name ||= class_sym.to_s.singularize

        define_method("drop_relationship_to_#{class_sym.to_s.singularize}") do |thing|
          if thing.is_a?(thing_klass)
            if @relationships = owned_relationships.where(in_relation_to_type: thing.class.name, in_relation_to_id: thing.id)
              @relationships.each{|r| r.destroy!}
            end
          end
        end

      end # define_method_drop_relationship_to_thing_local

    end
  end
end