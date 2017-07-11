module ActsAsRelatingTo
  module DefineMethods
    module UpdateRelationshipInvitationRemote
      def define_method_update_relationship_invitation_remote(class_sym, options={})

        define_method(:update_relationship_invitation_url) do
          @url = app_provider.url.clone
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/received_relationship_invitations/#{@invitation_id}"
          append_query('relationship_invitation')
        end

        define_method(:update_relationship_invitation) do |args|
          puts "#{self.class}.#{__method__}, args:"<<" #{args}".blue
          @called_by = __method__.to_s
          @invitation_id = args[:id]
          args.clone.tap do |c| 
            c.delete(:id)
            puts "#{self.class}.#{__method__}, c:"<<" #{c}".blue
            @query = c
          end
          generic('patch').tap do |remote_result|
            puts "#{self.class}.#{__method__}, remote_result:"<<" #{remote_result}".green
          end
        end

        private :update_relationship_invitation_url

      end
    end
  end
end