module SharingRelationshipInvitations
  module InstanceMethods
    module CancelRelationshipInvitiationAsSender

      def cancel_relationship_invitation_as_sender
        send("cancel_#{@relationship_invitation.status}_relationship_invitation_as_sender")
      end

    end
  end
end