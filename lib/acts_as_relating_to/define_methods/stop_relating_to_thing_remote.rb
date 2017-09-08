module ActsAsRelatingTo
  module DefineMethods
    module StopRelatingToThingRemote
      
      def define_method_stop_relating_to_thing_remote(class_sym, options={})
        thing_klass_name = options[:class_name]
        thing_klass_name ||= class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize
        thing_objekt_name = class_sym.to_s.singularize
        puts "#{self.class}.#{__method__}, api_version:"<<" #{api_version}".blue

        define_method("stop_relating_to_#{thing_objekt_name}_url") do
          @url = app_provider.uri.clone << "/api/" << api_version
          @url = "#{@url}/#{my_object_name.pluralize}/#{self.id}/stop_relating_to_thing"
          append_query
        end

        define_method("stop_relating_to_#{thing_objekt_name}") do |thing, options={}|
          if thing.is_a?(thing_klass)
            @query = options
            @query[:thing] = {id: thing.id, type: thing.class.name}
            @thing = thing
            @called_by = "stop_relating_to_#{thing_objekt_name}"
            result = generic('delete')
            [:url, :query, :thing, :called_by].each do |var_sym|
              remove_instance_variable("@#{var_sym}")
            end
            puts "in #{my_klass}.#{__method__}, result: #{result}"
            result.with_indifferent_access
          else
            raise "in #{my_klass}.#{__method__}, expected a #{thing_klass_name}, but got a #{thing.class.name}"
          end
        end

        private "stop_relating_to_#{thing_objekt_name}_url".to_sym

      end # define_method_stop_relating_to_thing_remote

    end
  end
end