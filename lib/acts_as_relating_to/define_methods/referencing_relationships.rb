module ActsAsRelatingTo
  module DefineMethods
    module ReferencingRelationships
      def define_method_referencing_relationships

        define_method(:referencing_relationships) do
          ActsAsRelatingTo::Relationship.where(in_relation_to_type: self.class, in_relation_to_id: self.id)
        end

      end
    end
  end
end