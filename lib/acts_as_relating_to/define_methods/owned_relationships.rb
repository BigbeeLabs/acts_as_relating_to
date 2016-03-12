module ActsAsRelatingTo
  module DefineMethods
    module OwnedRelationships
      def define_method_owned_relationships

        define_method(:owned_relationships) do 
          ActsAsRelatingTo::Relationship.where(owner_type: self.class, owner_id: self.id)
        end
        
      end
    end
  end
end