module SharingRelationshipInvitations
  module DefineMethods
    module RelationshipInvitationsRemote
      def define_method_relationship_invitations_remote(class_sym, options={})

        define_method(:relationship_invitations_url) do 
          @url = app_provider.uri.clone << "/api/" << api_version
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/relationship_invitations"
          append_query
        end

        define_method(:relationship_invitations) do 
          @called_by = __method__.to_s
          generic('get')
        end

        private :relationship_invitations_url

      end
    end
  end
end