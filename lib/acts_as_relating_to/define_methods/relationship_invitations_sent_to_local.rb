module ActsAsRelatingTo
  module DefineMethods
    module RelationshipInvitationsSentToLocal
      def define_method_relationship_invitations_sent_to_local(class_sym, options={})

        define_method :relationship_invitations_sent_to do |thing|
          sent_relationship_invitations.where(recipient: thing)
        end

      end
    end
  end
end