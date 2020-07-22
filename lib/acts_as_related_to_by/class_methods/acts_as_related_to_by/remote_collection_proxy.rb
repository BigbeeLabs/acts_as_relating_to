module ActsAsRelatedToBy
  module ClassMethods
    module ActsAsRelatedToBy
      module RemoteCollectionProxy

        attr_accessor *%w(
          __klass_args
          __self
          __required_objekt_klass
          __meth_name
          credential
        ).freeze

        def <<(objekt, args={})
          @__required_objekt_klass = __klass_args[:class_name].constantize
          @credential = __self.credential

          error = "#{__self.class}.#{__meth_name}.<< expected a #{__required_objekt_klass} but got a #{objekt.class}."
          raise ArgumentError.new(error) unless objekt.is_a?(__required_objekt_klass)

          generic(:post).tap do |remote_results|
            #puts "in " << "#{__self.class.name}.#{__method__}".white << ", " << "remote_results: " << "#{remote_results}".red
          end
        end

        def include?(objekt)
          @__required_objekt_klass = __klass_args[:class_name].constantize          
          error = "#{__self.class}.#{__meth_name}.include? expected a #{__required_objekt_klass} but got a #{objekt.class}."
          raise ArgumentError.new(error) unless objekt.is_a?(__required_objekt_klass)
          error = "#{__self.class}.#{__meth_name}.include? #{objekt.class} must have an id."
          raise ArgumentError.new(error) if objekt.id.blank? 
          !self.select do |x|
            x.id.to_i == objekt.id.to_i
          end.blank?
        end

      end
    end
  end
end