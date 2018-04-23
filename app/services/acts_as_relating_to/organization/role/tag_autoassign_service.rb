class ActsAsRelatingTo::Organization::Role::TagAutoassignService < ActsAsRelatingTo::ServiceBase

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

  use_peer_service_for  :autoassign_people,
                        :find_has_a

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      has_a_to_tag.set_tag_list_on :autoassign, 'true'
      has_a_to_tag.save
      autoassign_people(args)
    end

  private

    def has_a_to_tag
      @has_a_to_tag ||= find_has_a(args)
    end

end
