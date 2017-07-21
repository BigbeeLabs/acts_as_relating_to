module ActsAsRelatingTo
  module ClassMethods
    module Simple

      def acts_as_relating_to_simple(classes_array)
        classes_array.each do |class_sym|
          acts_as_relating_to_base class_sym
        end
      end

      private :acts_as_relating_to_simple
      
    end
  end
end