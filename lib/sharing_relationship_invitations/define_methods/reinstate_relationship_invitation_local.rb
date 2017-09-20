module SharingRelationshipInvitations
  module DefineMethods
    module ReinstateRelationshipInvitationLocal
      def define_method_reinstate_relationship_invitation_local(class_sym, options={})

        define_method(:reinstate_relationship_invitation) do |options|
          @relationship_invitation = options[:relationship_invitation]
          @relationship_invitation ||= find_relationship_invitation(id: options[:id])
          if i_am_the_relationship_invitation_sender?
            reinstate_relationship_invitation_as_sender
          else
            raise
          end
        end

      end
    end
  end
end