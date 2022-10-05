# == Schema Information
#
# Table name: acts_as_relating_to_relationships
#
#  id                  :integer          not null, primary key
#  owner_id            :integer
#  owner_type          :string
#  in_relation_to_id   :integer
#  in_relation_to_type :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

module ActsAsRelatingTo
  class Relationship < ActiveRecord::Base
    # ==========================================================================
    #  Validations
    # ==========================================================================
      validates :owner_id,
                :owner_type,
                :in_relation_to_id,
                :in_relation_to_type,
                presence: true
      
    # ==========================================================================
    #  Associations
    # ==========================================================================
      belongs_to  :owner,               polymorphic: true, optional: true
      belongs_to  :in_relation_to,      polymorphic: true, optional: true
    
    # ==========================================================================
    #  ActsAs Modules
    # ==========================================================================
      acts_as_taggable
      acts_as_taggable_on :roles
      acts_as_having :roles, class_name: 'ActsAsRelatingTo::Role'
    
    class << self 

      def with_owner(owner)
        where(owner_type: owner.class.name, owner_id: owner.id)
      end

      def with_role(role)
        where(
          id: ActsAsHaving::HasA.
          where(hased: role, haser_type: 'ActsAsRelatingTo::Relationship').
          pluck(&:haser_id)
        )
      end

    end


  end
end
