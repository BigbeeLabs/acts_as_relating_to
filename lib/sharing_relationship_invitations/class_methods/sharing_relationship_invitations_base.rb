module SharingRelationshipInvitations
  module ClassMethods
    module SharingRelationshipInvitationsBase

      def sharing_relationship_invitations_base(class_sym, options={})
        methods_to_define = [
          :invite_thing_to_relationship,
          :received_relationship_invitations,
          :sent_relationship_invitations,
          :update_relationship_invitation,
          :relationship_invitations_sent_to
        ]
        methods_to_define.each do |method_name|
          send("define_method_#{method_name}_#{(options[:remote] ? 'remote' : 'local')}", class_sym, options)
        end
      end

    end
  end
end