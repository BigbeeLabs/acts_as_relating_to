module SharingRelationshipInvitations
  module DefineMethods
    module DestroyRelationshipInvitationRemote
      def define_method_destroy_relationship_invitation_remote(class_sym, options={})

        define_method(:destroy_relationship_invitation_url) do 
          puts "#{self.class}.#{__method__}, "<<"fuck off".red
          @url = app_provider.uri.clone << "/api/" << api_version
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/relationship_invitations/#{@options[:id]}"
          append_query
=begin          
=end          
        end

        define_method(:destroy_relationship_invitation) do |options|
          puts "#{self.class}.#{__method__}, options:"<<" #{options}".green
          if options[:id]
            @options = options
            @called_by = __method__.to_s
            generic('delete').tap{|remote_result| puts "#{self.class}.#{__method__}, remote_result:"<<" #{remote_result}".green}
          end
=begin          
          @called_by = __method__.to_s
          generic('get')
=end
        end

        #private :destroy_relationship_invitation_remote_url

      end
    end
  end
end