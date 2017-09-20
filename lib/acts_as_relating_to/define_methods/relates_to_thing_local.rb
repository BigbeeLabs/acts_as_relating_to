module ActsAsRelatingTo
  module DefineMethods
    module RelatesToThingLocal
      def define_method_relates_to_thing_local(class_sym, options={})
        singular = class_sym.to_s.singularize

        define_method("relates_to_#{singular}?") do |thing, args={}|

          owned_relationships.
            where(
              in_relation_to_type: thing.class.name, 
              in_relation_to_id: thing.id
            ).
            first.
            tap do |relationship|
              return false unless relationship
              if args[:as]
                if role = Role.find_by(name: args[:as])
                  return relationship.roles.include?(role)
                else
                  return relationship.role_list.include?(args[:as])
                end
              else
                return true
              end
            end
        end

      end
    end
  end
end