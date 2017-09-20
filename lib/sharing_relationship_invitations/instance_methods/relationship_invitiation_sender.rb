module SharingRelationshipInvitations
  module InstanceMethods
    module RelationshipInvitiationSender

      def relationship_invitation_sender
        @relationship_invitation_sender ||= @relationship_invitation.sender
      end

    end
  end
end