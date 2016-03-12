module ActsAsRelatingTo
  module ClassMethods
    module UnrelateTo

=begin    
      def unrelate_to(options={})
        puts "in #{self}.#{__method__}"
        thing = options[:in_relation_to_type].constantize.find(options[:in_relation_to_id])
        rels = Relationship.where(owner_type: self, in_relation_to: thing)
        rels.each do |rel|
          object = self.find(rel[:owner_id])
          object.unrelate_to(thing)
        end
      end
=end

    end
  end
end