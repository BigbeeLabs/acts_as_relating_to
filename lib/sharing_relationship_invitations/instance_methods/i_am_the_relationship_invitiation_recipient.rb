module SharingRelationshipInvitations
  module InstanceMethods
    module IAmTheRelationshipInvitiationRecipient

      def i_am_the_relationship_invitation_recipient?
        @relationship_invitation.recipient == self
      end

    end
  end
end