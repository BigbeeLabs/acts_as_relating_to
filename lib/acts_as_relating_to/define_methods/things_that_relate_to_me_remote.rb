module ActsAsRelatingTo
  module DefineMethods
    module ThingsThatRelateToMeRemote

      def define_method_things_that_relate_to_me_remote(class_sym, options={})
        thing_klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        thing_klass = thing_klass_name.constantize

        define_method("#{class_sym.to_s}_that_relate_to_me_url") do |options={}|
          @url = app_provider.url.clone
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/things_that_relate_to_me"
          append_query
        end

        define_method("#{class_sym.to_s}_that_relate_to_me") do |options={}|
          @called_by = __method__.to_s
          @query = options
          @query[:thing_type] = class_sym.to_s
          generic('get').tap do |remote_result|
            @called_by = nil
            @query = nil
            @url = nil
            remote_result = JSON.parse(remote_result) if remote_result.is_a?(String)
            if remote_result.is_a?(Hash)
              return [thing_klass.new(remote_result)]
            else
              return remote_result.map{|thing_hsh| thing_klass.new(thing_hsh)}
            end
          end
          []
        end
      end

    end
  end
end