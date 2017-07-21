module ActsAsRelatingTo
  module DefineMethods
    module RelatesToThingRemote
      def define_method_relates_to_thing_remote(class_sym, options={})
        singular = class_sym.to_s.singularize

        define_method("relates_to_#{singular}?") do |thing, args={}|
          puts "#{self.class}.#{__method__}, thing.inspect:"<<" #{thing.inspect}".blue
        end

      end
    end
  end
end