module ActsAsRelatingTo
  module ClassMethods
    module Optioned
      def acts_as_relating_to_optioned(spec)
        puts "in #{self}.#{__method__}, spec: #{spec}"
      end
    end
  end
end