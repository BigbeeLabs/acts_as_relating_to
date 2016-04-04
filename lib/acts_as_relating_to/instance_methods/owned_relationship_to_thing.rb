module ActsAsRelatingTo
  module InstanceMethods
    module OwnedRelationshipToThing
      def owned_relationship_to (thing)
        owned_relationships.where(in_relation_to_type: thing.class, in_relation_to_id: thing.id)
      end
      
    end
  end
end