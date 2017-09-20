module SharingRelationshipInvitations
  module InstanceMethods
    module CancelAcceptedRelationshipInvitiationAsSender

      def cancel_accepted_relationship_invitation_as_sender
        self.class.name.underscore.tap do |sender_type|
          relationship_invitation_recipient.send("stop_relating_to_#{sender_type}", self, as: relationship_invitation_role_name)
        end
        @relationship_invitation.status = 'cancelled_accepted'
        @relationship_invitation.save!
        @relationship_invitation
      end

    end
  end
end