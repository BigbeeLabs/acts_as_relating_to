module ActsAsRelatingTo
  module DefineMethods
    module StopRelatingToThing
      
      def define_method_stop_relating_to_thing(class_sym, options={})
        if options[:remote]
          define_method_stop_relating_to_thing_remote(class_sym, options)
        else
          define_method_stop_relating_to_thing_local(class_sym, options)
        end
      end 

      private :define_method_stop_relating_to_thing

    end
  end
end