require_dependency 'acts_as_relating_to/class_methods/ar_has_many'
require_dependency 'acts_as_relating_to/class_methods/base'
#require_dependency 'acts_as_relating_to/shared_methods/is_array_of_keys'
require_dependency 'acts_as_relating_to/class_methods/optioned'
require_dependency 'acts_as_relating_to/class_methods/poro_has_many'
require_dependency 'acts_as_relating_to/class_methods/simple'
require_dependency 'acts_as_relating_to/class_methods/unrelate_to'

module ActsAsRelatingTo
  module ClassMethods
    include ArHasMany
    include Base
#    include IsArrayOfKeys
    include Optioned
    include PoroHasMany
    include Simple
    include UnrelateTo
  end
end