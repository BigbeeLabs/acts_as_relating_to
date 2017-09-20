module SharingRelationshipInvitations
  module InstanceMethods

    Gem::Specification.find_by_name("acts_as_relating_to").gem_dir.tap do |gem_dir|
      Dir["#{gem_dir}/lib/sharing_relationship_invitations/instance_methods/**/*.rb"].each do |f|
        require_dependency f
        f.split('/').last.split('.').first.camelize.tap do |module_name|
          include "SharingRelationshipInvitations::InstanceMethods::#{module_name}".constantize
        end
      end
    end


  end
end