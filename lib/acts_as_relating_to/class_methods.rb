require_dependency 'acts_as_relating_to/class_methods/base'
require_dependency 'acts_as_relating_to/class_methods/ar_has_many'
require_dependency 'acts_as_relating_to/class_methods/optioned'
require_dependency 'acts_as_relating_to/class_methods/poro_has_many'
require_dependency 'acts_as_relating_to/class_methods/simple'
require_dependency 'acts_as_relating_to/class_methods/unrelate_to'

module ActsAsRelatingTo
  module ClassMethods
    include ArHasMany
    include PoroHasMany
    include UnrelateTo
    include Simple
    include Optioned
    include Base
  end
end