module ActsAsRelatingTo
  module DefineMethods
    module ThingsLocal

      def things_local(class_sym, options={})

        things_klass_name = options[:class_name]
        things_klass_name ||= class_sym.to_s.singularize.camelize 

        define_method(class_sym) do |args={}|
          things_klass = things_klass_name.constantize
          rels = owned_relationships
          rels = rels.tagged_with(options[:as]) if options[:as]
          rels = rels.where(in_relation_to_type: things_klass_name)
          rels_ids = rels.pluck(:in_relation_to_id)
          things_klass.where(id: rels_ids)
        end

      end # things_local
      
    end
  end
end