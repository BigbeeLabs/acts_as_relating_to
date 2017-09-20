module SharingRelationshipInvitations
  module InstanceMethods
    module DeclineAcceptedRelationshipInvitiationAsRecipient

      def decline_accepted_relationship_invitation_as_recipient
        relationship_invitation_sender.class.name.underscore.tap do |sender_type|
          send("stop_relating_to_#{sender_type}", relationship_invitation_sender, as: relationship_invitation_role_name)
        end
        @relationship_invitation.status = 'declined'
        return @relationship_invitation.save!
      end

    end
  end
end