require_dependency 'acts_as_relating_to/define_methods/add_related_thing'
require_dependency 'acts_as_relating_to/define_methods/add_related_thing_local'
require_dependency 'acts_as_relating_to/define_methods/add_related_thing_remote'
require_dependency 'acts_as_relating_to/define_methods/drop_relationship_to_thing'
require_dependency 'acts_as_relating_to/define_methods/owned_relationships'
require_dependency 'acts_as_relating_to/define_methods/owned_relationships_to_things'
require_dependency 'acts_as_relating_to/define_methods/referencing_relationships'
require_dependency 'acts_as_relating_to/define_methods/things_i_relate_to'
require_dependency 'acts_as_relating_to/define_methods/things'
require_dependency 'acts_as_relating_to/define_methods/things_local'
require_dependency 'acts_as_relating_to/define_methods/things_remote'
require_dependency 'acts_as_relating_to/define_methods/things_that_relate_to_me'

module ActsAsRelatingTo
  module DefineMethods
    include AddRelatedThing
    include AddRelatedThingLocal
    include AddRelatedThingRemote
    include DropRelationshipToThing
    include OwnedRelationships
    include OwnedRelationshipsToThings
    include ReferencingRelationships
    include Things
    include ThingsLocal
    include ThingsRemote
    include ThingsIRelateTo
    include ThingsThatRelateToMe
  end
end