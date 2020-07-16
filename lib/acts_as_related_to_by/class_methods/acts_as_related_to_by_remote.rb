module ActsAsRelatedToBy
  module ClassMethods
    module ActsAsRelatedToByRemote

=begin
      module POROProxy

        def include?(objekt)
          raise "#{self.class}.#{__method__}".red unless objekt.is_a?(__klass__)
          self.map{|o| o.id}.include?(objekt.id)
        end

        def ids
          self.map{|o| o.id}
        end

      end
=end
      def acts_as_related_to_by_remote(meth_name, class_args)

        class_name = class_args[:class_name]
        class_name ||= meth_name.to_s.camelize

        contexts = class_args[:context]
        context_keys = contexts.map{|context| context.keys.first}.compact if contexts

        define_method("#{meth_name}_url") do 
          @url = "#{app_provider.uri.clone}/api/#{api_version}/"
          @url << self.class.name.demodulize.underscore.pluralize
          @url << "/#{self.id}/#{meth_name}"
          append_query
          @url
        end

        define_method(meth_name) do |instance_args={}|
          
          if contexts && context_keys.include?(:organization)
            raise

            context = OpenStruct.new(contexts.find{|c| c.keys.first == :organization}[:organization])
            organization_key = context.organization_key.try(:to_sym)
            organization_key ||= context.organization_type.demodulize.underscore.to_sym
            organization_klass = context.organization_type.constantize
            organization = args[organization_key]


          end

          if contexts && context_keys.include?(:legal)
            @query ||= {}

            context = OpenStruct.new(contexts.find{|c| c.keys.first == :legal}[:legal])

            document_holder_key = context.document_holder_key.try(:to_sym)
            document_holder_key ||= context.document_holder_type.demodulize.underscore.to_sym


            document_holder_klass = context.document_holder_type.constantize
            document_holder = instance_args[document_holder_key]

            error = "The #{document_holder_key} argument is missing for the #{self.class.name}.#{meth_name} method."
            raise ArgumentError.new(error) unless document_holder

            @query[document_holder_key] ||= {}
            @query[document_holder_key][:id] = document_holder.id
            #@query[:context][:legal][:document_holder_id] = document_holder.id

          end

          @called_by = meth_name
          
          collection = []

          generic('get').tap do |remote_results|
            remote_results = JSON.parse(remote_results) if remote_results.is_a?(String)
            collection = remote_results.map{|r| class_name.constantize.new(id: r['id'])}
          end

          collection.extend(RemoteCollectionProxy) unless collection.is_a?(RemoteCollectionProxy)
          unless collection.is_a?(BigbeeLabs::RemoteModels::Base)
            collection.class_eval do 
              include BigbeeLabs::RemoteModels::Base
            end
          end
          collection.instance_variable_set(:@__klass_args, class_args)
          collection.instance_variable_set(:@__self, self)
          collection.instance_variable_set(:@__meth_name, meth_name)


          collection
        end

      end

    end
  end
end
