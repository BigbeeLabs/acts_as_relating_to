module SharingRelationshipInvitations
  module DefineMethods
    module ReceivedRelationshipInvitationsLocal
      def define_method_received_relationship_invitations_local(class_sym, options={})
        define_method(:received_relationship_invitations) do 
          RelationshipInvitation.where(recipient: self)
        end
      end
    end
  end
end