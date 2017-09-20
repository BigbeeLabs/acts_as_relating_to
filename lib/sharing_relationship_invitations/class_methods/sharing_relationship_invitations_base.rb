module SharingRelationshipInvitations
  module ClassMethods
    module SharingRelationshipInvitationsBase

      def sharing_relationship_invitations_base(class_sym, options={})
        methods_to_define = [
          :accept_relationship_invitation,
          :cancel_relationship_invitation,
          :decline_relationship_invitation,
          :destroy_relationship_invitation,
          :find_relationship_invitation,
          :invite_thing_to_relationship,
          :relationship_invitations,
          :relationship_invitations_sent_to,
          :received_relationship_invitations,
          :reinstate_relationship_invitation,
          :sent_relationship_invitations,
          :update_relationship_invitation
        ]
        methods_to_define.each do |method_name|
          send("define_method_#{method_name}_#{(options[:remote] ? 'remote' : 'local')}", class_sym, options)
        end
      end

    end
  end
end