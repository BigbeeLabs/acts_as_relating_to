module SharingRelationshipInvitations
  module DefineMethods
    module SentRelationshipInvitationsRemote
      def define_method_sent_relationship_invitations_remote(class_sym, options={})

        define_method(:sent_relationship_invitations_url) do 
          @url = app_provider.url.clone
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/sent_relationship_invitations"
          append_query
        end

        define_method(:sent_relationship_invitations) do 
          @called_by = __method__.to_s
          generic('get').tap do |remote_result|
            @called_by = nil
            @url = nil
          end
        end

        private :sent_relationship_invitations_url

      end
    end
  end
end