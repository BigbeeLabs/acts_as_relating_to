module SharingRelationshipInvitations
  module DefineMethods
    module FindRelationshipInvitationLocal
      def define_method_find_relationship_invitation_local(class_sym, options={})

        define_method(:find_relationship_invitation) do |options|
          ActsAsRelatingTo::RelationshipInvitation.find_by(options)
        end

      end
    end
  end
end