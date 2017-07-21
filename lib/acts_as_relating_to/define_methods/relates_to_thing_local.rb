module ActsAsRelatingTo
  module DefineMethods
    module RelatesToThingLocal
      def define_method_relates_to_thing_local(class_sym, options={})
        singular = class_sym.to_s.singularize

        define_method("relates_to_#{singular}?") do |thing, args={}|
          if r = owned_relationships.where(in_relation_to_type: thing.class.name, in_relation_to_id: thing.id).first
            if args[:as]
              if role = Role.find_by(name: args[:as])
                r.roles.include?(role)
              else
                r.role_list.include?(args[:as])
              end
            else
              true
            end
          else
            false
          end
        end

      end
    end
  end
end