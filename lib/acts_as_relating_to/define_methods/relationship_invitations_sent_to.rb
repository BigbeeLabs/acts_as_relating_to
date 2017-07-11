module ActsAsRelatingTo
  module DefineMethods
    module RelationshipInvitationsSentTo
      def define_method_relationship_invitations_sent_to(class_sym, options={})
        if options[:remote]
          define_method_relationship_invitations_sent_to_remote class_sym, options
        else
          define_method_relationship_invitations_sent_to_local class_sym, options
        end
      end
    end
  end
end