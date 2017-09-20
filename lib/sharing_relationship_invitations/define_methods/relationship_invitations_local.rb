module SharingRelationshipInvitations
  module DefineMethods
    module RelationshipInvitationsLocal
      def define_method_relationship_invitations_local(class_sym, options={})

        define_method(:relationship_invitations) do 
          puts "#{self.class}.#{__method__}, "<<"message".red
        end

      end
    end
  end
end