Gem::Specification.find_by_name("acts_as_relating_to").gem_dir.tap do |gem_dir|
  Dir["#{gem_dir}/lib/sharing_relationship_invitations/**/*.rb"].each do |f|
    require_dependency f
  end
end

module ActsAsSharingRelationshipInvitations
  def acts_as_sharing_relationship_invitations_with(*classes_array)
    puts "#{self.class}.#{__method__}, classes_array:"<<" #{classes_array}".blue
    puts "#{self.class}.#{__method__}, is_array_of_keys?(classes_array):"<<" #{is_array_of_keys?(classes_array)}".red
    
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
=begin
require 'active_support/dependencies'
#require 'acts_as_relating_to/relationship'
require_dependency 'acts_as_relating_to/class_methods'
require_dependency 'acts_as_relating_to/define_methods'
require_dependency 'acts_as_relating_to/shared_methods'
require_dependency 'acts_as_relating_to/instance_methods'
require_dependency 'bigbee_labs/associations'
require_dependency 'acts_as_having'

module ActsAsRelatingTo
  def acts_as_relating_to(*classes_array)

    class_eval do
      include InstanceMethods
      include SharedMethods
      extend  SharedMethods
      extend  ClassMethods
      extend  DefineMethods
      extend  BigbeeLabs::Associations::ClassMethods
      extend  ActsAsHaving
    end

    if self < ActiveRecord::Base
      before_destroy :tell_to_unrelate
      #ar_has_many
    else
      #poro_has_many
    end

    if is_array_of_keys?(classes_array)
      acts_as_relating_to_simple classes_array
    else
      acts_as_relating_to_optioned classes_array
    end

  end
end
=end
ActiveRecord::Base.extend ActsAsSharingRelationshipInvitations