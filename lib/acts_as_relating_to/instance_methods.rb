module ActsAsRelatingTo
  module InstanceMethods

    #===========================================================================
    def create_relationship(owner,in_relation_to)
      Relationship.create!(
        owner_type:           owner.class,
        owner_id:             owner.id,
        in_relation_to_type:  in_relation_to.class,
        in_relation_to_id:    in_relation_to.id
      )
    end
    
    #===========================================================================
    def tell_to_unrelate
      referencing_relationships.each do |referencing_relationship|
        referencing_relationship.owner.unrelate_to self
      end
    end

    #===========================================================================
    # TODO Able to accept either string or array for options[:as]
    #===========================================================================
    def relate_to(related_thing, options={})
      unless @relationship = relationship_to(related_thing).first
        @relationship = create_relationship self, related_thing
      end
      unless options[:as].nil?
        @relationship.role_list.add options[:as]
        @relationship.save
      end
    end

    #===========================================================================
    def relates_to?(thing)
      relationship_to(thing).count > 0
    end 

    #===========================================================================
    def relates_to_as?(thing, role)
      relationship_to(thing).tagged_with(role).count > 0
    end
  
    #===========================================================================
    def relationship_to(thing)
      # CUSTOM_LOGGER.info "in #{self.class.name}.#{__method__}"
      owned_relationships.where(in_relation_to_id: thing.id, in_relation_to_type: thing.class.name)
    end
    
    def unrelate_to(thing)
      relationship_to(thing).first.destroy!
    end

  end #Instance Methods
end