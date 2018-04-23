class ActsAsRelatingTo::Organization::Role::UntagBaseRoleService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    {organization: [:id]},
    {role: [:id]},
    :token
  ].freeze

  REQUIRED_ARGS = %w(
    organization
    role 
    token
  ).freeze

  REQUIRED_VALUES = %w(
    organization_id 
    role_id
    token
  ).freeze

  delegate *%w(
    organization_id
    role_id
  ), to: :decorated_args
  
  use_peer_service_for  :update_people_with_current_base_role

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      @role = find_role
      @organization = new_organization
      has_a_to_untag.set_tag_list_on(:base_role, 'false')
      has_a_to_untag.save 
      update_people_with_current_base_role
    end

  private

    def current_base_role_name
      role.name 
    end

    def new_base_role_name
      'friend'
    end

    def find_role
      ActsAsRelatingTo::Role.find_by(id: role_id)
    end

    def new_organization
      BigbeeGraph::Organization.new(id: organization_id)
    end

    def has_a_to_untag 
      @has_a_to_untag ||= organization.has_as.find_by(hased: role)
    end

end
