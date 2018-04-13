module ActsAsRelatingTo
  module DefineMethods
    module RelatesToThingRemote

      def define_method_relates_to_thing_remote(class_sym, options={})
        singular = class_sym.to_s.singularize
        expected_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        expected_klass = expected_klass_name.constantize

        define_method("relates_to_#{singular}_url") do 
          @url = app_provider.uri.clone << '/api/' << api_version
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/relates_to/#{singular}/#{@thing.id}"
          append_query
        end

        define_method("relates_to_#{singular}?") do |thing, args={}|
          if thing.is_a?(expected_klass)
            @thing = thing
            @called_by = "relates_to_#{singular}"
            @query = args
            @credential = {token: token}
            #@query[:thing] = {thing_type: thing.class.name, thing_id: thing.id}
            generic('get').tap do |remote_result|
              #puts "#{self.class}.#{__method__}, remote_result:"<<" #{remote_result}".green
            end
          else
            raise "#{self.class}.#{__method__}, "<<"WARNING! Expected a #{expected_klass_name} but got a #{thing.class.name}".red
          end

        end

      end
    end
  end
end