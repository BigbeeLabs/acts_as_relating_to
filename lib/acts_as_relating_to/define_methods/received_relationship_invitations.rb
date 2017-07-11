module ActsAsRelatingTo
  module DefineMethods
    module ReceivedRelationshipInvitations
      def define_method_received_relationship_invitations(class_sym, options={})
        if options[:remote]
          define_method_received_relationship_invitations_remote class_sym, options
        else
          define_method_received_relationship_invitations_local class_sym, options
        end
      end
    end
  end
end