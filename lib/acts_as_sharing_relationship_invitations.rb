Gem::Specification.find_by_name("acts_as_relating_to").gem_dir.tap do |gem_dir|
  Dir["#{gem_dir}/lib/sharing_relationship_invitations/**/*.rb"].each do |f|
    require_dependency f
  end
end

module ActsAsSharingRelationshipInvitations
  def acts_as_sharing_relationship_invitations_with(*classes_array)
    
    class_eval do 
      include SharingRelationshipInvitations::InstanceMethods
      extend SharingRelationshipInvitations::DefineMethods
      extend SharingRelationshipInvitations::ClassMethods
    end

    if is_array_of_keys?(classes_array)
      classes_array.each do |class_sym|
        sharing_relationship_invitations_base class_sym
      end
    else
      sharing_relationship_invitations_base classes_array[0], classes_array.pop
    end    

  end
end

ActiveRecord::Base.extend ActsAsSharingRelationshipInvitations