class ActsAsRelatingTo::Organization::Role::PeopleThatRelateAsService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    :related_as
  ].freeze

  REQUIRED_ARGS = %w(
    
  ).freeze

  REQUIRED_VALUES = %w(
    organization_id
    related_as
    token
  ).freeze

  delegate *%w(
    organization_id
    token
  ), to: :decorated_args
  
  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      new_organization.people_that_relate_to_me as: related_as
    end

  private

    def new_organization
      BigbeeGraph::Organization.new(id: organization_id, credential: {token: token})
    end

end
