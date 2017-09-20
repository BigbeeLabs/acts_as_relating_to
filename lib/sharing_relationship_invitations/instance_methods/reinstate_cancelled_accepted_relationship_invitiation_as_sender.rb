module SharingRelationshipInvitations
  module InstanceMethods
    module ReinstateCancelledAcceptedRelationshipInvitiationAsSender

      def reinstate_cancelled_accepted_relationship_invitation_as_sender
        self.class.name.underscore.tap do |sender_type|
          relationship_invitation_recipient.send("relate_to_#{sender_type}", self, as: relationship_invitation_role_name)
        end
        @relationship_invitation.status = 'accepted'
        @relationship_invitation.save!
      end

    end
  end
end