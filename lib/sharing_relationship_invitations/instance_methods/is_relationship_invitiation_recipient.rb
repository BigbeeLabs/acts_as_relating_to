module SharingRelationshipInvitations
  module InstanceMethods
    module IsRelationshipInvitiationRecipient

      def is_relationship_invitation_recipient?
        @relationship_invitation.recipient == self
      end

    end
  end
end