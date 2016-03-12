require_dependency 'acts_as_relating_to/define_methods/owned_relationships'
require_dependency 'acts_as_relating_to/define_methods/referencing_relationships'
require_dependency 'acts_as_relating_to/define_methods/things_that_relate_to_me'


module ActsAsRelatingTo
  module DefineMethods
    include OwnedRelationships
    include ReferencingRelationships
    include ThingsThatRelateToMe
  end
end