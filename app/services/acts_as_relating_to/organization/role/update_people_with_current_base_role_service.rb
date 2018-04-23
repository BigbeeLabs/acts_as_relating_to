class ActsAsRelatingTo::Organization::Role::UpdatePeopleWithCurrentBaseRoleService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    :current_base_role_name,
    :new_base_role_name,
    {organization: [:id]},
    :token
  ].freeze

  REQUIRED_ARGS = %w(
    current_base_role_name
    new_base_role_name
    organization
    token
  ).freeze

  REQUIRED_VALUES = %w(
    current_base_role_name
    new_base_role_name
    organization_id
    token
  ).freeze

  delegate *%w(
    organization_id
  ), to: :decorated_args

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      puts "#{self.class}.#{__method__}, args:"<<" #{args}".green
      puts "#{self.class}.#{__method__}, people_to_relate:"<<" #{people_to_relate}".green
      people_to_relate.each do |person|
        person.using_credential(token: token).relate_to_organization bigbee_organization, as: new_base_role_name
      end
    end

  private

    def bigbee_organization; @bigbee_organization ||= new_bigbee_organization end
    
    def new_bigbee_organization
      BigbeeGraph::Organization.new(id: organization_id, credential: {token: token})
    end

    def people_to_relate; @people_to_relate ||= get_people_to_relate end
    
    def get_people_to_relate
      people_related_with_current_role.select{|person| !people_ids_related_with_new_role.include?(person.id)}
    end

    def people_related_with_new_role
      @people_related_with_new_role ||= fetch_people_related_with_new_role
    end
    
    def fetch_people_related_with_new_role
      bigbee_organization.people_that_relate_to_me as: new_base_role_name
    end

    def people_ids_related_with_new_role
      people_related_with_new_role.map(&:id)
    end

    def people_related_with_current_role
      @people_related_with_current_role ||= fetch_people_related_with_current_role
    end
    
    def fetch_people_related_with_current_role
      bigbee_organization.people_that_relate_to_me as: current_base_role_name
    end

    def people_ids_related_with_current_role
      people_related_with_current_role.map(&:id)
    end

end
