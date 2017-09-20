module SharingRelationshipInvitations
  module InstanceMethods
    module RelationshipInvitiationRecipient

      def relationship_invitation_recipient
        @relationship_invitation_recipient ||= @relationship_invitation.recipient
      end

    end
  end
end