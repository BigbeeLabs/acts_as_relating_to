module ActsAsRelatingTo
  module SharedMethods
    module IsArrayOfKeys

      private
      
      def is_array_of_keys?(array)
        array.all?{|x| x.is_a? Symbol}
      end
      
    end
  end
end