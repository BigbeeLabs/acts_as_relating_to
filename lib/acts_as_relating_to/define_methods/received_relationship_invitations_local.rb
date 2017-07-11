module ActsAsRelatingTo
  module DefineMethods
    module ReceivedRelationshipInvitationsLocal
      def define_method_received_relationship_invitations_local(class_sym, options={})
        define_method(:received_relationship_invitations) do 
          puts "#{self.class}.#{__method__}, self.id:"<<" #{self.id}".blue
          RelationshipInvitation.where(recipient: self)
        end
      end
    end
  end
end