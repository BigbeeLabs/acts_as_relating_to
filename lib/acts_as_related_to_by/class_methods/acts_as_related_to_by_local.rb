module ActsAsRelatedToBy
  module ClassMethods
    module ActsAsRelatedToByLocal

      define_method_referencing_relationships

      def acts_as_related_to_by_local(meth_name, class_args)

        klass_name = class_args[:class_name]
        klass_name ||= meth_name.to_s.singularize.camelize
        klass = klass_name.constantize

        role_name = class_args[:in_role] unless class_args[:in_role].blank?
        role_name ||= meth_name.to_s.singularize.to_sym

        contexts = class_args[:context]
        context_keys = contexts.map{|context| context.keys.first}.compact if contexts

        organization_context_data = {}
        legal_context_data = {}

        define_method(meth_name) do |args={}|

          referencing_relationships = send(:referencing_relationships).where(owner_type: klass_name)

          if contexts
            context_keys.each do |context_key|
              referencing_relationships = referencing_relationships.tagged_with(role_name.to_s, on: "#{context_key}_roles".to_sym)
            end
          else
            referencing_relationships = referencing_relationships.tagged_with(role_name.to_s, on: :roles)
          end

          if contexts && context_keys.include?(:organization)

            context = OpenStruct.new(contexts.find{|c| c.keys.first == :organization}[:organization])
            organization_key = context.organization_key.try(:to_sym)
            organization_key ||= context.organization_type.demodulize.underscore.to_sym
            organization_klass = context.organization_type.constantize
            organization = args[organization_key]

            organization_error = "The #{organization_key} key is missing for the #{self.class.name}.#{meth_name} method."
            raise ArgumentError.new(organization_error) unless organization

            correct_class_error = "Expected #{organization_key} to be a #{organization_klass} but got a #{organization.class}"
            raise ArgumentError.new(correct_class_error) unless organization.is_a?(organization_klass)

            organization_context_data[organization_key] = organization

            organization_relationships_ids = ActsAsHaving::HasA.where(
              hased_type: organization.class.name,
              hased_id:   organization.id,
              haser_type: 'ActsAsRelatingTo::Relationship'
            ).pluck(:haser_id)

            referencing_relationships = referencing_relationships.
                                          where(id: organization_relationships_ids)
          end

          if contexts && context_keys.include?(:legal)

            context = OpenStruct.new(contexts.find{|c| c.keys.first == :legal}[:legal])

            document_holder_key = context.document_holder_key.try(:to_sym)
            document_holder_key ||= context.document_holder_type.demodulize.underscore.to_sym
            document_holder_klass = context.document_holder_type.constantize
            document_holder = args[document_holder_key]

            error = "The #{document_holder_key} argument is missing for the #{self.class.name}.#{meth_name} method."
            raise ArgumentError.new(error) unless document_holder

            error = "Expected the #{document_holder_key} argument to be a #{document_holder_klass} but got a #{document_holder.class}"
            raise ArgumentError.new(error) unless document_holder.is_a?(document_holder_klass)

            legal_context_data[document_holder_key] = document_holder
            legal_document_klass = context.document_type.constantize

            error = "#{legal_document_klass} does not respond to #{:for_document_holder}."
            raise NoMethodError.new(error) unless legal_document_klass.respond_to?(:for_document_holder)

            legal_document_ids = legal_document_klass.for_document_holder(document_holder).select{|doc| doc.in_force?}.pluck(:id)

            legal_document_relationship_ids = ActsAsHaving::HasA.where(
              hased_type: context.document_type,
              hased_id:   legal_document_ids,
              haser_type: 'ActsAsRelatingTo::Relationship'
            ).pluck(:haser_id)

            referencing_relationships = referencing_relationships.where(id: legal_document_relationship_ids)
          end

          collection = if klass.is_a?(ActiveRecord::Base)
            raise "#{self.class}.#{__method__}".red
          else
            referencing_relationships.map{|rr| klass.new(id: rr.owner_id)}
          end

          return if collection.is_a?(CollectionProxy)
          
          collection.extend(CollectionProxy)
          collection.extend(POROProxy) unless klass.is_a?(ActiveRecord::Base)
          collection.instance_variable_set(:@__self__, self)
          collection.instance_variable_set(:@__klass__, klass)
          collection.instance_variable_set(:@__in_role__, role_name)
          collection.instance_variable_set(:@__organization__, organization)
          collection.instance_variable_set(:@__klass_args__, class_args)
          collection.instance_variable_set(:@__meth_name__, meth_name)
          collection.instance_variable_set(:@__organization_context_data__, organization_context_data)
          collection.instance_variable_set(:@__legal_context_data__, legal_context_data)
          return collection

        end
      end

    end
  end
end
