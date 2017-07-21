module ActsAsRelatingTo
  module DefineMethods
    module RelateToThingLocal
      def define_method_relate_to_thing_local(class_sym, options={})
        singular = class_sym.to_s.singularize

        define_method("relate_to_#{singular}") do |thing, args={}|
          puts "#{self.class}.#{__method__}, thing.inspect:"<<" #{thing.inspect}".red
          puts "#{self.class}.#{__method__}, args:"<<" #{args}".green
          unless @relationship = owned_relationship_to(thing).first
            @relationship = owned_relationships.create!(in_relation_to_type: thing.class.name, in_relation_to_id: thing.id)
          end
          if args[:as]
            if role = Role.find_by(name: args[:as])
              @relationship.have_this_role role
              if role.reciprocal
                unless thing.send("relates_to_#{singular}?", self, as: role.reciprocal)
                  thing.send("relate_to_#{singular}", self, as: role.reciprocal)
                end
              end
            else
              @relationship.role_list.add(args[:as])
              @relationship.save!
              @relationship.reload
            end
          end
          true
        end

      end
    end
  end
end