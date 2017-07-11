module ActsAsRelatingTo
  module DefineMethods
    module InviteThingToRelationship
      def define_method_invite_thing_to_relationship(class_sym, options={})
        if options[:remote]
          define_method_invite_thing_to_relationship_remote class_sym, options
        else
          define_method_invite_thing_to_relationship_local class_sym, options
        end
      end
    end
  end
end