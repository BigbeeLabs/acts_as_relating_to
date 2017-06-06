module ActsAsRelatingTo
  module DefineMethods
    module ThingsIRelateTo
      def define_method_things_i_relate_to(class_sym, options={})
        thing_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize

        define_method(class_sym.to_s+"_i_relate_to") do |options={}|
          relationships = owned_relationships.where(in_relation_to_type: thing_klass_name)
          relationships = relationships.tagged_with(options[:as]) if options[:as]
          thing_klass.where(id: relationships.pluck(:in_relation_to_id))
        end

      end
    end
  end
end