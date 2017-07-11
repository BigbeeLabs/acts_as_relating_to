# == Schema Information
#
# Table name: acts_as_relating_to_relationship_invitations
#
#  id             :integer          not null, primary key
#  sender_id      :integer
#  sender_type    :string
#  recipient_id   :integer
#  recipient_type :string
#  status         :integer          default(0)
#  role_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

module ActsAsRelatingTo
  class RelationshipInvitation < ActiveRecord::Base
    # ==========================================================================
    #  Validations
    # ==========================================================================
      validates :sender_id,
                :sender_type,
                :recipient_id,
                :recipient_type,
                :status,
                :role_id,
                presence: true
      
    # ==========================================================================
    #  Associations
    # ==========================================================================
      belongs_to  :sender,      polymorphic: true
      belongs_to  :recipient,   polymorphic: true
      belongs_to  :role,        class_name: 'ActsAsRelatingTo::Role'
    
    # ==========================================================================
    #  ActsAs Modules
    # ==========================================================================
=begin
      acts_as_taggable
      acts_as_taggable_on :roles
      acts_as_having :roles, class_name: 'ActsAsRelatingTo::Role'    
=end
    # ==========================================================================
    #  Callbacks
    # ==========================================================================
      after_initialize :set_status

    # ==========================================================================
    #  enums
    # ==========================================================================
      enum status: {pending: 0, accepted: 1, declined: 2, revoked: 3}

    private

      def set_status
        self.status ||= 0
      end

  end
end
