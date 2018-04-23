class ActsAsRelatingTo::Organization::Role::CurrentBaseRoleNameService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    {organization: [:id]}    
  ].freeze

  REQUIRED_ARGS = %w(
    organization
  ).freeze

  REQUIRED_VALUES = %w(
    organization_id
  ).freeze

  delegate *%w(
    organization_id
  ), to: :decorated_args
  
  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      tagged_has_a ? role.name : 'friend'
    end

  private

    def bigbee_organization
      @bigbee_organization ||= BigbeeGraph::Organization.new(id: organization_id)
    end

    def tagged_has_a
      bigbee_organization.
        has_as.
        where(hased_type: 'ActsAsRelatingTo::Role').
        tagged_with('true', on: :base_role).
        first
    end

    def role 
      @role ||= ActsAsRelatingTo::Role.find_by(id: tagged_has_a.hased_id)
    end

end
