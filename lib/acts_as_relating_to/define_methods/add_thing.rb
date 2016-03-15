module ActsAsRelatingTo
  module DefineMethods
    module AddThing
      def define_method_add_thing(class_sym, options={})
        thing_objekt_name = class_sym.to_s.singularize
        define_method("add_#{thing_objekt_name}") do |thing|
          thing_klass_name = options[:class_name] if options[:class_name]
          thing_klass_name = thing_objekt_name.camelize unless options[:class_name]
          thing_klass = thing_klass_name.constantize
          if thing.is_a?(thing_klass)
            relationship = nil
            if thing.class < ActiveRecord::Base
              relationship = owned_relationships.create(in_relation_to: thing)
            else
              relationship = owned_relationships.create(in_relation_to_type: thing.class.name, in_relation_to_id: thing.id)
            end
            if options[:as]
              relationship.role_list.add(options[:as])
              relationship.save
            end
          else
            puts "in #{self.class}.#{__method__}, best not to nibble"
          end
        end
      end
    end
  end
end