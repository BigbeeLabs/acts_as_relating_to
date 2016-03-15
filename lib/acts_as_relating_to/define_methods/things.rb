module ActsAsRelatingTo
  module DefineMethods
    module Things
      def define_method_things(class_sym, options={})
        things_klass_name = options[:class_name]
        things_klass_name ||= class_sym.to_s.singularize.camelize 

        define_method(class_sym) do |args={}|
          things_klass = things_klass_name.constantize
          rels = owned_relationships.tagged_with(options[:as]) if options[:as]
          rels = rels.where(in_relation_to_type: things_klass_name)
          rels_ids = rels.pluck(:in_relation_to_id)
          things_klass.find_by(id: rels_ids)
        end

        define_method("#{class_sym}_ids") do 
          things_klass = things_klass_name.constantize
          rels = owned_relationships.tagged_with(options[:as]) if options[:as]
          rels = rels.where(in_relation_to_type: things_klass_name)
          rels.pluck(:in_relation_to_id)
        end

      end
    end
  end
end