module ActsAsRelatingTo
  module DefineMethods
    module Things
      def define_method_things(class_sym, options={})
        things_klass_name = options[:class_name]
        things_klass_name ||= class_sym.to_s.singularize.camelize 

        define_method("#{class_sym}_ids") do 
          things_klass = things_klass_name.constantize
          rels = owned_relationships.tagged_with(options[:as]) if options[:as]
          rels = rels.where(in_relation_to_type: things_klass_name)
          rels.pluck(:in_relation_to_id)
        end

        if options[:remote]
          things_remote class_sym, options
        else
          things_local class_sym, options
        end

      end
    end
  end
end