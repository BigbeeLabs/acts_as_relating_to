module SharingRelationshipInvitations
  module InstanceMethods
    module IAmTheRelationshipInvitiationSender

      def i_am_the_relationship_invitation_sender?
        @relationship_invitation.sender == self
      end

    end
  end
end