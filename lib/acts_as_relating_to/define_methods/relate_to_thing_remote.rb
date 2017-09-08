module ActsAsRelatingTo
  module DefineMethods
    module RelateToThingRemote
      def define_method_relate_to_thing_remote(class_sym, options={})
        expected_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        expected_klass = expected_klass_name.constantize
        singular = class_sym.to_s.singularize

        define_method("relate_to_#{singular}_url") do 
          puts "#{self.class}.#{__method__}, api_version:"<<" #{api_version}".red
          @url = app_provider.uri.clone << '/api/' << api_version
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/relate_to_thing"
          append_query
        end

        define_method("relate_to_#{singular}") do |thing, args={}|
          if thing.is_a?(expected_klass)
            @thing = thing
            @called_by = __method__.to_s
            @query = args
            @query[:thing] = {thing_type: thing.class.name, thing_id: thing.id}
            generic('post').tap do |remote_result|
              puts "#{self.class}.#{__method__}, remote_result:"<<" #{remote_result}".green
            end
          else
            raise "#{self.class}.#{__method__}, "<<"WARNING! Expected a #{expected_klass_name} but got a #{thing.class.name}".red
          end
        end

      end
    end
  end
end