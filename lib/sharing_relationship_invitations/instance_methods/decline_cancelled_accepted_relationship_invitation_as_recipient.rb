module SharingRelationshipInvitations
  module InstanceMethods
    module DeclineCancelledAcceptedRelationshipInvitationAsRecipient

      def decline_cancelled_accepted_relationship_invitation_as_recipient
        @relationship_invitation.status = 'cancelled_declined'
        @relationship_invitation.save!
      end

    end
  end
end