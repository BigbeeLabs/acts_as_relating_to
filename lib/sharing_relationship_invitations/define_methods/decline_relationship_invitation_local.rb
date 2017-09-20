module SharingRelationshipInvitations
  module DefineMethods
    module DeclineRelationshipInvitationLocal
      def define_method_decline_relationship_invitation_local(class_sym, options={})

        define_method(:decline_relationship_invitation) do |options|
          @relationship_invitation = options[:relationship_invitation]
          @relationship_invitation ||= find_relationship_invitation(id: options[:id])
          if @relationship_invitation
            if i_am_the_relationship_invitation_recipient?
              decline_relationship_invitation_as_recipient
            else
              raise "#{self.class}.#{__method__}, "<<"NOT IMPLEMENTED!".red
            end
          else
            false
          end
        end

      end
    end
  end
end