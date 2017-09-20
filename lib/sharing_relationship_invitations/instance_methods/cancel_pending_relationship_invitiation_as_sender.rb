module SharingRelationshipInvitations
  module InstanceMethods
    module CancelPendingRelationshipInvitiationAsSender

      def cancel_pending_relationship_invitation_as_sender
        @relationship_invitation.destroy
        nil
      end

    end
  end
end