module SharingRelationshipInvitations
  module InstanceMethods
    module ReinstateCancelledDeclinedRelationshipInvitiationAsSender

      def reinstate_cancelled_declined_relationship_invitation_as_sender
        @relationship_invitation.status = 'declined'
        @relationship_invitation.save!
      end

    end
  end
end