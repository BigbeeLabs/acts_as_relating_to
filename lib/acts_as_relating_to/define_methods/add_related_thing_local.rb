module ActsAsRelatingTo
  module DefineMethods
    module AddRelatedThingLocal
      def define_method_add_related_thing_local(class_sym, options={})

        thing_objekt_name = class_sym.to_s.singularize

        define_method("add_#{thing_objekt_name}") do |thing|

          thing_klass_name = options[:class_name]
          thing_klass_name ||= thing_objekt_name.camelize
          thing_klass = thing_klass_name.constantize

          if thing.is_a?(thing_klass)
            unless @relationship = owned_relationship_to(thing).first
              @relationship = owned_relationships.create(
                in_relation_to_type: thing.class.name, 
                in_relation_to_id:   thing.id)
            end
            if options[:as]
              unless @relationship.role_list.include?(options[:as])
                @relationship.role_list.add(options[:as])
                @relationship.save
              end
            end
            return true
          else
            puts "in #{self.class}.#{__method__}, best not to nibble"
            raise "in #{self.class}.#{__method__}, expected a #{thing_klass_name}, but got a #{thing.class}"
          end

        end # define_method

      end
    end
  end
end