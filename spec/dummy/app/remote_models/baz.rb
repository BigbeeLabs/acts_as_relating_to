class Baz
  include BigbeeLabs::RemoteModels::Base
  extend ActsAsRelatingTo
  extend ActsAsSharingRelationshipInvitations

  APP_PROVIDER_NAME = 'bigbee_graph'
  my_klass.remote_attributes  += [:id]
  acts_as_relating_to :people, class_name: 'Bar', remote: true
  acts_as_relating_to :hamsters, class_name: 'Baz', remote: true
  acts_as_sharing_relationship_invitations_with :people, class_name: 'Bar', remote: true

end