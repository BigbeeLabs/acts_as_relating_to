module SharingRelationshipInvitations
  module InstanceMethods
    module ReinstateRelationshipInvitiationAsSender

      def reinstate_relationship_invitation_as_sender
        send("reinstate_#{@relationship_invitation.status}_relationship_invitation_as_sender")
      end

    end
  end
end