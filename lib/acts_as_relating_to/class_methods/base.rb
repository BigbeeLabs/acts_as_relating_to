module ActsAsRelatingTo
  module ClassMethods
    module Base
      def acts_as_relating_to_base(class_sym, options={})
        puts "in #{self}.#{__method__}, class_sym: #{class_sym}"
        puts "in #{self}.#{__method__}, options: #{options}"
      end
    end
  end
end