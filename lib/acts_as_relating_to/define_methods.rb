require_dependency 'acts_as_relating_to/define_methods/add_thing'
require_dependency 'acts_as_relating_to/define_methods/owned_relationships'
require_dependency 'acts_as_relating_to/define_methods/owned_relationships_to_things'
require_dependency 'acts_as_relating_to/define_methods/referencing_relationships'
require_dependency 'acts_as_relating_to/define_methods/things_i_relate_to'
require_dependency 'acts_as_relating_to/define_methods/things'
require_dependency 'acts_as_relating_to/define_methods/things_that_relate_to_me'

module ActsAsRelatingTo
  module DefineMethods
    include AddThing
    include OwnedRelationships
    include OwnedRelationshipsToThings
    include ReferencingRelationships
    include Things
    include ThingsIRelateTo
    include ThingsThatRelateToMe
  end
end