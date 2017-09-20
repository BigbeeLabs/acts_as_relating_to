module SharingRelationshipInvitations
  module InstanceMethods
    module DeclinePendingRelationshipInvitiationAsRecipient

      def decline_pending_relationship_invitation_as_recipient
        @relationship_invitation.status = 'declined'
        return @relationship_invitation.save!
      end

    end
  end
end