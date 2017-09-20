module SharingRelationshipInvitations
  module InstanceMethods
    module DeclineRelationshipInvitiationAsRecipient

      def decline_relationship_invitation_as_recipient
        send("decline_#{@relationship_invitation.status}_relationship_invitation_as_recipient")
      end

    end
  end
end