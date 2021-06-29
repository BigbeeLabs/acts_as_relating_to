module ActsAsRelatingTo
  module DefineMethods
    module ThingsIRelateToLocal
      def define_method_things_i_relate_to_local(class_sym, options={})
        thing_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize

        define_method(class_sym.to_s+"_i_relate_to") do |options={}|
          relationships = owned_relationships.where(in_relation_to_type: thing_klass_name)
          relationships = relationships.tagged_with(options[:as]) if options[:as]
          if thing_klass < ActiveRecord::Base
            thing_klass.where(id: relationships.pluck(:in_relation_to_id))
          elsif thing_klass < BigbeeLabs::RemoteModels::Base
            relationships.
              pluck(:in_relation_to_id).
              map{ |id| thing_klass.new(id: id) }
          else
            raise "#{self.class}.#{__method__}".red 
          end
        end
        
      end
    end
  end
end