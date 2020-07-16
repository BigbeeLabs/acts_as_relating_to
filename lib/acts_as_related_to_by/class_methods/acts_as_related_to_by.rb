module ActsAsRelatedToBy
  module ClassMethods
    module ActsAsRelatedToBy

      module POROProxy

        def include?(objekt)
          raise "#{self.class}.#{__method__}".red unless objekt.is_a?(__klass__)
          self.map{|o| o.id}.include?(objekt.id)
        end

        def ids
          self.map{|o| o.id}
        end

      end

      def acts_as_related_to_by(meth_name, class_args)
        if class_args[:remote]
          acts_as_related_to_by_remote(meth_name, class_args)
        else
          acts_as_related_to_by_local(meth_name, class_args)
        end
      end


    end
  end
end
