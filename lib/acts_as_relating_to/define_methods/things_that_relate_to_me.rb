module ActsAsRelatingTo
  module DefineMethods
    module ThingsThatRelateToMe

      def define_method_things_that_relate_to_me(class_sym, options={})
        define_method_location_switch class_sym, options
        
=begin        
        puts "#{self}##{__method__}, class_sym:"<<" #{class_sym}".red
        thing_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize
        define_method(class_sym.to_s + "_that_relate_to_me") do |options={}|
          relationships = referencing_relationships.where("owner_type=?", thing_klass_name)
          relationships = relationships.tagged_with(options[:as]) if options[:as]
          thing_klass.where(id: relationships.pluck(:owner_id))
        end
=end
      end

    end
  end
end