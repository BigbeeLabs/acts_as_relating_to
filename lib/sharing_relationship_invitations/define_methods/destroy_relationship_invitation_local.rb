module SharingRelationshipInvitations
  module DefineMethods
    module DestroyRelationshipInvitationLocal
      def define_method_destroy_relationship_invitation_local(class_sym, options={})

        define_method(:destroy_relationship_invitation_local) do |options|
          puts "#{self.class}.#{__method__}, options:"<<" #{options}".green
        end

      end
    end
  end
end