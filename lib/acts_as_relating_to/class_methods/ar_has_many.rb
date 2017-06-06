module ActsAsRelatingTo
  module ClassMethods
    module ArHasMany
      def ar_has_many
        
        has_many :owned_relationships,
          as: :owner,
          class_name: "ActsAsRelatingTo::Relationship",
          dependent: :destroy
                                       
        has_many :referencing_relationships,
          as: :in_relation_to,
          class_name: "ActsAsRelatingTo::Relationship",
          dependent: :destroy

      end
    end
  end
end