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

        #def <<(objekt, args={})
        def <<(objekt, args={})
          @__required_objekt_klass = __klass_args[:class_name].constantize
          @credential = __self.credential
          puts "in " << "#{__self.class.name}.#{__method__}".white << ", " << "credential: " << "#{credential}".blue

          error = "#{__self.class}.#{__meth_name}.<< expected a #{__required_objekt_klass} but got a #{objekt.class}."
          raise ArgumentError.new(error) unless objekt.is_a?(__required_objekt_klass)

          generic(:post).tap do |remote_results|
            puts "in " << "#{__self.class.name}.#{__method__}".white << ", " << "remote_results: " << "#{remote_results}".red
          end
        end

      end
    end
  end
end