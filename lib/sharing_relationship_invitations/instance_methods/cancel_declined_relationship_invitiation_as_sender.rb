module SharingRelationshipInvitations
  module InstanceMethods
    module CancelDeclinedRelationshipInvitiationAsSender

      def cancel_declined_relationship_invitation_as_sender
        @relationship_invitation.status = 'cancelled_declined'
        @relationship_invitation.save!
        @relationship_invitation
      end

    end
  end
end