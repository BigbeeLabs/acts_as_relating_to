module ActsAsRelatingTo
  module DefineMethods
    module RelatesToThing
      def define_method_relates_to_thing(class_sym, options={})
        define_method_location_switch class_sym, options
      end
    end
  end
end