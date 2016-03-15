module ActsAsRelatingTo
  module DefineMethods
    module ThingsIRelateTo
      def define_method_things_i_relate_to(class_sym, options={})
        thing_klass_name = class_sym.to_s.singularize.camelize

        define_method(class_sym.to_s+"_i_relate_to") do |options={}|
          thing_klass = thing_klass_name.constantize
          thing_ids = []
          if options[:as]
            thing_ids = owned_relationships.tagged_with(options[:as])
                                     .where(in_relation_to_type: thing_klass_name)
                                     .pluck(:in_relation_to_id)
          else
            thing_ids = owned_relationships.where(in_relation_to_type: thing_klass_name)
                                     .pluck(:in_relation_to_id)
          end
          thing_klass.where(id: thing_ids).all
        end

      end
    end
  end
end