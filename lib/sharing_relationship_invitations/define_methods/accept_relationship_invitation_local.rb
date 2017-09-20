module SharingRelationshipInvitations
  module DefineMethods
    module AcceptRelationshipInvitationLocal
      def define_method_accept_relationship_invitation_local(class_sym, options={})

        define_method(:accept_relationship_invitation) do |options|
          @relationship_invitation = options[:relationship_invitation]
          @relationship_invitation ||= find_relationship_invitation(id: options[:id])
          if i_am_the_relationship_invitation_recipient?
            accept_relationship_invitation_as_recipient
          else
            raise
          end
        end

      end
    end
  end
end