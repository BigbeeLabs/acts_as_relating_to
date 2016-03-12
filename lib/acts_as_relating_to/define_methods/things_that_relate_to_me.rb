module ActsAsRelatingTo
  module DefineMethods
    module things_that_relate_to_me

      def define_method_things_that_relate_to_me(class_sym, options={})

        define_method(class_sym.to_s + "_that_relate_to_me") do |options={}|
          if options[:as]
            ids = referencing_relationships.tagged_with(options[:as]).where("owner_type=?", class_sym.to_s.singularize.camelize).map{|t| t.owner_id}
            class_sym.to_s.singularize.camelize.constantize.find(ids)
          else
            ids = referencing_relationships.where("owner_type=?", class_sym.to_s.singularize.camelize).map{|t| t.owner_id}
            class_sym.to_s.singularize.camelize.constantize.find(ids)
          end
        end

      end

    end
  end
end