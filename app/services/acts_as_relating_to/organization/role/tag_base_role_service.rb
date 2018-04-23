class ActsAsRelatingTo::Organization::Role::TagBaseRoleService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    {organization: [:id]},
    {role: [:id]}
  ].freeze

  REQUIRED_ARGS = %w(
    organization
    role
  ).freeze

  REQUIRED_VALUES = %w(
    organization_id
    role_id
  ).freeze

  delegate *%w(
    organization_id
    role_id
  ), to: :decorated_args
  
  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      @role = find_role
      has_a_to_tag.set_tag_list_on :base_role, 'true'
      has_a_to_tag.save
      has_as_to_untag.each do |has_a_to_untag|
        has_a_to_untag.set_tag_list_on :base_role, 'false'
        has_a_to_untag.save 
      end
    end

  private

    def bigbee_organization
      @bigbee_organization ||= BigbeeGraph::Organization.new(id: organization_id)
    end

    def tagged_has_as
      @tagged_has_as ||= has_as.tagged_with(:true, on: :base_role)
    end
    
    def has_a_to_tag
      @has_a_to_tag ||= has_as.where(hased: role).first
    end
    
    def has_as_to_untag
      @has_as_to_untag ||= tagged_has_as.where.not(id: has_a_to_tag.id)
    end

    def has_as
      @has_as ||= bigbee_organization.has_as.where(hased_type: 'ActsAsRelatingTo::Role')
    end
    
    def find_role
      ActsAsRelatingTo::Role.find_by(id: role_id)
    end
    
end
