module SharingRelationshipInvitations
  module InstanceMethods
    module AcceptRelationshipInvitiationAsRecipient

      def accept_relationship_invitation_as_recipient
        send("accept_#{@relationship_invitation.status}_relationship_invitation_as_recipient")
      end

    end
  end
end