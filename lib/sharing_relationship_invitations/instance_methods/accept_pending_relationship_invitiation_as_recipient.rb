module SharingRelationshipInvitations
  module InstanceMethods
    module AcceptPendingRelationshipInvitiationAsRecipient

      def accept_pending_relationship_invitation_as_recipient
        @relationship_invitation.sender_type.tap do |sender_type|
          if send(
            "relate_to_#{sender_type.underscore}", 
            relationship_invitation_sender, 
            as: relationship_invitation_role_name
          )
            @relationship_invitation.status = 'accepted'
            return @relationship_invitation.save!
          else
            raise "#{self.class}.#{__method__}, "<<"Not Implemented!".red
          end
        end
        
      end

    end
  end
end