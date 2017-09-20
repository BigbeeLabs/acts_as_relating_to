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
          role_name = options[:as]
          right_kind_of_thing = thing.is_a?(thing_klass)
          i_relate_to_thing = send("relates_to_#{thing_object_name}?", thing, as: role_name)
          if right_kind_of_thing && i_relate_to_thing
            #----------------------------------------------------------------------------
            # set some variables
            #----------------------------------------------------------------------------
            role = Role.find_by(name: role_name)
            reciprocal_role_name = role.try(:reciprocal)
            relationship = owned_relationship_to(thing).first
            keep_relationship = nil
            #----------------------------------------------------------------------------
            # remove role_name from tag list
            #----------------------------------------------------------------------------
            if role_name
              relationship.role_list.remove(options[:as])
              relationship.save
              keep_relationship ||= relationship.role_list.any?
            end
            #----------------------------------------------------------------------------
            # drop role
            #----------------------------------------------------------------------------
            relationship.drop_this_role(role) if role
            keep_relationship ||= relationship.roles.any?
            #----------------------------------------------------------------------------
            # destroy relationship
            #----------------------------------------------------------------------------
            relationship.destroy! unless keep_relationship
            #----------------------------------------------------------------------------
            # call reciprocal method
            #----------------------------------------------------------------------------
            if reciprocal_role_name
              thing.send("stop_relating_to_#{self.class.name.underscore}", self, as: reciprocal_role_name)
            end
            true
          else
            false
          end
        end

      end # define_method_stop_relating_to_thing_local

    end
  end
end