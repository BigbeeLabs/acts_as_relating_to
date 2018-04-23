class ActsAsRelatingTo::Organization::Role::FindHasAService < ActsAsRelatingTo::ServiceBase

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
      @organization = new_organization
      organization.has_as.find_by(hased: role)
    end

  private

    def find_role
      ActsAsRelatingTo::Role.find_by(id: role_id)
    end

    def new_organization
      BigbeeGraph::Organization.new(id: organization_id)
    end

end
