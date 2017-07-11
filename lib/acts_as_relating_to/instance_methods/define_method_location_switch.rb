module ActsAsRelatingTo
  module InstanceMethods
    module DefineMethodLocationSwitch
      def define_method_location_switch (class_sym, options={})
        puts "#{self}##{__method__}, class_sym:"<<" #{class_sym}".green
        puts "#{self.class}.#{__method__}, caller[0][/`.*'/][1..-2]:"<<" #{caller[0][/`.*'/][1..-2]}".red
        caller[0][/`.*'/][1..-2].tap do |called_by|
          send "#{called_by}_#{options[:remote] ? 'remote' : 'local'}", class_sym, options
        end
      end
      
    end
  end
end