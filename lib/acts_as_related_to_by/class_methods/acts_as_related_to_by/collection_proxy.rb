module ActsAsRelatedToBy
  module ClassMethods
    module ActsAsRelatedToBy
      module CollectionProxy

        attr_accessor *%w(
          __klass_name__
          __self__
          __klass__
          __in_role__
          __organization__
          __klass_args__
          __required_objekt_klass__
          __meth_name__
          __organization_context_data__
          __legal_context_data__
        ).freeze

        #def <<(objekt, args={})
        def <<(objekt, args={})

          @__required_objekt_klass__ = __klass_args__[:class_name].constantize

          error = "#{__self__.class}.#{__meth_name__}.<< expected a #{__required_objekt_klass__} but got a #{objekt.class}."
          raise ArgumentError.new(error) unless objekt.is_a?(__required_objekt_klass__)

          ActiveRecord::Base.transaction do 

            relationship = __self__.
              send(:referencing_relationships).
              find_or_create_by!(
                owner_id: objekt.id,
                owner_type: objekt.class.name,
                in_relation_to_type: __self__.class.name,
                in_relation_to_id: __self__.id
              )

            if contexts = __klass_args__[:context]
              context_keys = contexts.map{|c| c.keys.first.to_sym}
              legal_context = OpenStruct.new(contexts.find{|c| c.keys.first.to_sym == :legal}[:legal]) if context_keys.include?(:legal)
              organization_context = OpenStruct.new(contexts.find{|c| c.keys.first.to_sym == :organization}[:organization]) if context_keys.include?(:organization)
            end

#            puts "in " << "#{__self__.class}.#{__method__}".white << ", " << "__in_role__: " << "#{__in_role__}".light_blue
            if __in_role__
              if context_keys.blank?
                tag_list = relationship.tag_list_on(:roles)
                tag_list << __in_role__.to_s unless tag_list.include?(__in_role__)
                relationship.set_tag_list_on(:roles, tag_list)
                relationship.save!
              else
#                puts "in " << "#{__self__.class}.#{__method__}".white << ", " << "context_keys: " << "#{context_keys}".pink
                context_keys.each do |context_key|
                  tag_list = relationship.tag_list_on("#{context_key}_roles".to_sym)
                  tag_list << __in_role__.to_s unless tag_list.include?(__in_role__)
                  relationship.set_tag_list_on("#{context_key}_roles".to_sym, tag_list)
                  relationship.save!
                end
              end
            end

            if legal_context
              # was a document provided?
              arg_key = legal_context.document_type_key
              arg_key ||= legal_context.document_type.demodulize.underscore.to_sym
              document = args[arg_key]
              error = "#{__self__.class}.#{__meth_name__}.<< expected a #{arg_key} but didn't get one."
              raise ArgumentError.new(error) unless document

              # was a document holder provided?
              arg_key = legal_context.document_holder_key
              arg_key ||= legal_context.document_holder_type.demodulize.underscore.to_sym
              document_holder = __legal_context_data__[arg_key]
              error = "#{__self__.class}.#{__meth_name__}.<< expected an #{arg_key} but didn't get one."
              raise ArgumentError.new(error) unless document_holder

              # document holder is of the correct class?
              document_holder_klass = legal_context.document_holder_type.constantize
              error = "#{__self__.class}.#{__meth_name__}.<< expected an #{document_holder_klass} but got a #{document_holder.class}."
              raise ArgumentError.new(error) unless document_holder.is_a?(document_holder_klass)

              # does the provided document holder hold the provided document?
              error = "The provided document is not held by the provided document holder."
              puts "in " << "#{self.class.name}.#{__method__}".white << ", " << "document_holder.inspect: " << "#{document_holder.inspect}".yellow
              raise ArgumentError.new(error) unless document.held_by?(document_holder)

              # is the provided document in force?
              error = "The provided document is not currently in force."
              raise ArgumentError.new(error) unless document.in_force?

              ActsAsHaving::HasA.find_or_create_by!(
                hased_type: document.class.name,
                hased_id:   document.id,
                haser_type: relationship.class.name,
                haser_id:   relationship.id
              )

            end

            if organization_context

              organization = __organization_context_data__[:organization]

              ActsAsHaving::HasA.find_or_create_by!(
                hased_type: organization.class.name,
                hased_id:   organization.id,
                haser_type: relationship.class.name,
                haser_id:   relationship.id
              )

            end

          end # ActiveRecord::Base.transaction

          return {success: true}

        end

        def remove(objekt, args={})

          @__required_objekt_klass__ = __klass_args__[:class_name].constantize
          error = "#{__self__.class}.#{__meth_name__}.<< expected a #{__required_objekt_klass__} but got a #{objekt.class}."
          raise ArgumentError.new(error) unless objekt.is_a?(__required_objekt_klass__)

          ActiveRecord::Base.transaction do 

            relationship = __self__.
              send(:referencing_relationships).
              find_by!(
                owner_id: objekt.id,
                owner_type: objekt.class.name,
                in_relation_to_type: __self__.class.name,
                in_relation_to_id: __self__.id
              )

            relationship.tags_on(:roles).where(name: __in_role__).first.tap do |tag|
              relationship.taggings.where(tag: tag).destroy_all
            end

          end # ActiveRecord::Base.transaction
        end #remove

      end
    end
  end
end