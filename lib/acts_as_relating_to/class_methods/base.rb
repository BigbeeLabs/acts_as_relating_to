module ActsAsRelatingTo
  module ClassMethods
    module Base
      def acts_as_relating_to_base(class_sym, options={})
        puts "in #{self}.#{__method__}, class_sym: #{class_sym}"
        puts "in #{self}.#{__method__}, options: #{options}"
        methods_to_define = [
          "things_i_relate_to",
          "add_thing",
          "things"
        ]
        methods_to_define.each do |method_name|
          send "define_method_#{method_name}", class_sym, options
        end
        
      end
    end
  end
end