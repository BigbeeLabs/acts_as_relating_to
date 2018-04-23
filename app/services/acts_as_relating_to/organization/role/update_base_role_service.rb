class ActsAsRelatingTo::Organization::Role::UpdateBaseRoleService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    {organization: [:id]},
    {role: [:id]},
    :is_base_role,
    :token
  ].freeze

  REQUIRED_ARGS = %w(
    organization
    role
    is_base_role
    token
  ).freeze

  REQUIRED_VALUES = %w(
    organization_id
    role_id
    is_base_role
    token
  ).freeze

  delegate *%w(
    organization_id
    role_id
  ), to: :decorated_args

  use_peer_service_for  :current_base_role_name,
                        :tag_base_role,
                        :untag_base_role,
                        :update_people_with_current_base_role

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      puts "#{self.class}.#{__method__}, args:"<<" #{args}".green
      raise unless good_to_go?
      raise unless @role = find_role
      puts "#{self.class}.#{__method__}, is_base_role:"<<" #{is_base_role}".green
      puts "#{self.class}.#{__method__}, current_base_role_name:"<<" #{current_base_role_name}".green
      update_people_with_current_base_role 
      tag_base_role
=begin
      puts "#{self.class}.#{__method__}, tagged_has_a.inspect:"<<" #{tagged_has_a.inspect}".green
=end
    end

  private

    def new_base_role_name
      role.name
    end

    def find_role
      ActsAsRelatingTo::Role.find_by(id: role_id)
    end

=begin
    def current_base_role_name
      tagged_has_a ? tagged_has_a.hased.name : 'friend'
    end

    def tagged_has_a
      organization_has_as.tagged_with(:true, on: :base_role).first
    end

    def bigbee_organization; @bigbee_organization ||= new_bigbee_organization end
    
    def new_bigbee_organization
      BigbeeGraph::Organization.new(id: organization_id)
    end

    def organization_has_as
      @organization_has_as ||= bigbee_organization.has_as.where(hased_type: 'ActsAsRelatingTo::Role') 
    end
=end

end
