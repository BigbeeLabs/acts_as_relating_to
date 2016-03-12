module ActsAsRelatingTo
  module DefineMethods
    module OwnedRelationshipsToThings

      def define_method_owned_relationships_to_things(class_sym, options={})
        
        define_method("owned_relationships_to_" + class_sym.to_s) do
          owned_relationships.where(in_relation_to_type: "#{class_sym.to_s.singularize.camelize}")
        end  

      end
      
    end
  end
end