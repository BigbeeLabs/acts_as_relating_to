module ActsAsRelatingTo
  module InstanceMethods
    module DefineMethodLocationSwitch

      def define_method_location_switch (class_sym, options={})
        caller[0][/`.*'/][1..-2].tap do |called_by|
          send "#{called_by}_#{options[:remote] ? 'remote' : 'local'}", class_sym, options
        end
      end
      
    end
  end
end