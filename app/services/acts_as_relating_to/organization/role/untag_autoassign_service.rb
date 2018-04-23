class ActsAsRelatingTo::Organization::Role::UntagAutoassignService < ActsAsRelatingTo::ServiceBase

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

  use_peer_service_for :find_has_a
  
  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      has_a_to_untag.set_tag_list_on :autoassign, 'false'
      has_a_to_untag.save
    end

  private

    def has_a_to_untag; @has_a_to_untag ||= find_has_a(args) end

    def tagged_on
      :autoassign 
    end

end
