module SharingRelationshipInvitations
  module DefineMethods
    module CancelRelationshipInvitationRemote
      def define_method_cancel_relationship_invitation_remote(class_sym, options={})

        define_method(:cancel_relationship_invitation_url) do 
          @url = app_provider.uri.clone << "/api/" << api_version
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/relationship_invitations/#{@options[:id]}/cancel"
          append_query
        end

        define_method(:cancel_relationship_invitation) do |options|
          @options = options
          @called_by = __method__.to_s
          generic('post')
        end

        private :cancel_relationship_invitation_url

      end
    end
  end
end