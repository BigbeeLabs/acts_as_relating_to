module SharingRelationshipInvitations
  module DefineMethods
    module SentRelationshipInvitationsLocal
      def define_method_sent_relationship_invitations_local(class_sym, options={})

        class_eval do 
          has_many :sent_relationship_invitations, class_name: "ActsAsRelatingTo::RelationshipInvitation", as: :sender
        end        

      end
    end
  end
end