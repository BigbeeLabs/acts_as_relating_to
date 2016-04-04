module ActsAsRelatingTo
  module DefineMethods
    module AddRelatedThing
      def define_method_add_related_thing(class_sym, options={})
        if options[:remote]
          define_method_add_related_thing_remote class_sym, options
        else
          define_method_add_related_thing_local class_sym, options
        end
      end
    end
  end
end