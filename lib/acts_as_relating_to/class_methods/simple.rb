module ActsAsRelatingTo
  module ClassMethods
    module Simple
      def acts_as_relating_to_simple(classes_array)
        puts "in #{self}.#{__method__}, classes_array: #{classes_array}"
      end
    end
  end
end