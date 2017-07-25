module SharingRelationshipInvitations
  module DefineMethods
    module ReceivedRelationshipInvitationsRemote
      def define_method_received_relationship_invitations_remote(class_sym, options={})

        define_method(:received_relationship_invitations_url) do 
          @url = app_provider.url.clone
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/received_relationship_invitations"
          append_query
        end

        define_method(:received_relationship_invitations) do 
          @called_by = __method__.to_s
          generic('get')
        end

        private :received_relationship_invitations_url

      end
    end
  end
end