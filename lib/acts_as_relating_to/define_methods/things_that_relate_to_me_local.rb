module ActsAsRelatingTo
  module DefineMethods
    module ThingsThatRelateToMeLocal

      def define_method_things_that_relate_to_me_local(class_sym, options={})
        thing_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize

        define_method(class_sym.to_s + "_that_relate_to_me") do |options={}|
          relationships = referencing_relationships.where("owner_type=?", thing_klass_name)
          relationships = relationships.tagged_with(options[:as]) if options[:as]
          if thing_klass.is_a?(ActiveRecord::Base)
            thing_klass.where(id: relationships.pluck(:owner_id))
          else
            relationships.pluck(:owner_id).map{|id| thing_klass.new(id: id)}
          end
        end
      end

    end
  end
end