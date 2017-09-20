module SharingRelationshipInvitations
  module DefineMethods
    module CancelRelationshipInvitationLocal
      def define_method_cancel_relationship_invitation_local(class_sym, options={})

        define_method(:cancel_relationship_invitation) do |options|
          @relationship_invitation = options[:relationship_invitation]
          @relationship_invitation ||= find_relationship_invitation(id: options[:id])
          if @relationship_invitation
            if i_am_the_relationship_invitation_sender?
              cancel_relationship_invitation_as_sender
            else
              false
            end
          else
            false
          end
        end

      end
    end
  end
end