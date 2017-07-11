module ActsAsRelatingTo
  module DefineMethods
    module RelateToThingLocal
      def define_method_relate_to_thing_local(class_sym, options={})
        puts "#{self}##{__method__}, class_sym:"<<" #{class_sym}".light_blue
        puts "#{self}##{__method__}, options:"<<" #{options}".red

        singular = class_sym.to_s.singularize

        define_method("relate_to_#{singular}") do |thing, args={}|
          puts "#{self.class}.#{__method__}, thing.inspect:"<<" #{thing.inspect}".red
          send("#{class_sym}_i_relate_to").tap{|x| puts "#{self.class}.#{__method__}, x.inspect:"<<" #{x.inspect}".red}
        end

      end
    end
  end
end