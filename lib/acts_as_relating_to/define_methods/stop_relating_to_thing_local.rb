module ActsAsRelatingTo
  module DefineMethods
    module StopRelatingToThingLocal
      
      def define_method_stop_relating_to_thing_local(class_sym, options={})
        thing_klass_name = options[:class_name]
        thing_klass_name ||= class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize
        thing_object_name = options[:class_name].demodulize.underscore if options[:class_name]
        thing_object_name ||= class_sym.to_s.singularize

        define_method("stop_relating_to_#{class_sym.to_s.singularize}") do |thing, options={}|
          if thing.is_a?(thing_klass)
            Relationship.find_by(owner: self, in_relation_to: thing).tap do |relationship|
              if relationship
                if options[:as]
                  Role.find_by(name: options[:as]).tap do |role|
                    if role
                      raise
                    end
                  end
                  relationship.role_list.remove(options[:as])
                  relationship.save
                else
                end
              else
                return true
              end
            end
          else
            raise "in #{my_klass}.#{__method__}, expected a #{thing_klass_name}, but got a #{thing.class.name}"
          end
        end

      end # define_method_stop_relating_to_thing_local

    end
  end
end