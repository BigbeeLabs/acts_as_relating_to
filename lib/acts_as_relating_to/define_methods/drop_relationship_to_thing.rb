require_dependency 'acts_as_relating_to/define_methods/drop_relationship_to_thing_local'
require_dependency 'acts_as_relating_to/define_methods/drop_relationship_to_thing_remote'

module ActsAsRelatingTo
  module DefineMethods
    include DropRelationshipToThingLocal
    include DropRelationshipToThingRemote
    module DropRelationshipToThing
      
      def define_method_drop_relationship_to_thing(class_sym, options={})
        if options[:remote]
          define_method_drop_relationship_to_thing_remote(class_sym, options)
        else
          define_method_drop_relationship_to_thing_local(class_sym, options)
        end
      end # define_method_drop_relationship_to_thing

    end
  end
end