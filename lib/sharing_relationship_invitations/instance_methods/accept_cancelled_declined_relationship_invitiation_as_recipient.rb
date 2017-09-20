module SharingRelationshipInvitations
  module InstanceMethods
    module AcceptCancelledDeclinedRelationshipInvitiationAsRecipient

      def accept_cancelled_declined_relationship_invitation_as_recipient
        @relationship_invitation.status = 'cancelled_accepted'
        return @relationship_invitation.save!
      end

    end
  end
end