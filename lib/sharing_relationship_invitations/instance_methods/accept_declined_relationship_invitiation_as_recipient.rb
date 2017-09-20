module SharingRelationshipInvitations
  module InstanceMethods
    module AcceptDeclinedRelationshipInvitiationAsRecipient

      def accept_declined_relationship_invitation_as_recipient
        accept_pending_relationship_invitation_as_recipient
        @relationship_invitation.status = 'accepted'
        return @relationship_invitation.save!
      end

    end
  end
end