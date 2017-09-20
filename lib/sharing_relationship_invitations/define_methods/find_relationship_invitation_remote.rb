module SharingRelationshipInvitations
  module DefineMethods
    module FindRelationshipInvitationRemote
      def define_method_find_relationship_invitation_remote(class_sym, options={})

        define_method(:find_relationship_invitation) do 
          puts "#{self.class}.#{__method__}, "<<"message".red
        end

      end
    end
  end
end