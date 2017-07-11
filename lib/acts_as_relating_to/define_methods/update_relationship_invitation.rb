module ActsAsRelatingTo
  module DefineMethods
    module UpdateRelationshipInvitation
      def define_method_update_relationship_invitation(class_sym, options={})
        if options[:remote]
          define_method_update_relationship_invitation_remote class_sym, options
        else
          define_method_update_relationship_invitation_local class_sym, options
        end
      end
    end
  end
end