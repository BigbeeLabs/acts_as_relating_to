require "acts_as_relating_to/engine"
require 'active_support/dependencies'
#require 'acts_as_relating_to/relationship'
require_dependency 'acts_as_relating_to/class_methods'
require_dependency 'acts_as_relating_to/define_methods'
require_dependency 'acts_as_relating_to/shared_methods'
require_dependency 'acts_as_relating_to/instance_methods'
require_dependency 'bigbee_labs/associations'
require_dependency 'acts_as_having'
require_dependency 'acts_as_sharing_relationship_invitations'

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
      extend  ActsAsSharingRelationshipInvitations
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

ActiveRecord::Base.extend ActsAsRelatingTo
