module SharingRelationshipInvitations
  module DefineMethods
    module AcceptRelationshipInvitationRemote
      def define_method_accept_relationship_invitation_remote(class_sym, options={})

        define_method(:accept_relationship_invitation_url) do 
          @url = app_provider.uri.clone << "/api/" << api_version
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/relationship_invitations/#{@options[:id]}/accept"
          append_query
        end

        define_method(:accept_relationship_invitation) do |options|
          puts "#{self.class}.#{__method__}, options:"<<" #{options}".green
          @options = options
          @called_by = __method__.to_s
          generic('post')
        end

        private :accept_relationship_invitation_url

      end
    end
  end
end