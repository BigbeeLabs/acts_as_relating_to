class ActsAsRelatingTo::Organization::Role::DestroyService < ActsAsRelatingTo::ServiceBase

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

  use_peer_service_for  :current_base_role_name,
                        :find_has_a,
                        :people_that_relate_as,
                        :update_people_with_current_base_role
  
  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      puts "#{self.class}.#{__method__}, args:"<<" #{args}".red
      raise unless good_to_go?
      raise unless @role = has_a.hased
      raise unless @organization = new_organization
      puts "#{self.class}.#{__method__}, role.inspect:"<<" #{role.inspect}".green
      puts "#{self.class}.#{__method__}, has_a.inspect:"<<" #{has_a.inspect}".green
      puts "#{self.class}.#{__method__}, people_that_relate_as_role_to_destroy:"<<" #{people_that_relate_as_role_to_destroy}".green
      update_people_with_current_base_role if is_base_role?
      drop_relationships
      role.destroy!
      has_a.destroy!
    end

  private

    def drop_relationships
      people_that_relate_as_role_to_destroy.each do |person|
        puts "#{self.class}.#{__method__}, person.inspect:"<<" #{person.inspect}".green
        person.using_credential(token: token).stop_relating_to_organization organization, as: role.name
      end
    end

    def new_base_role_name
      'friend'
    end

    def has_a 
      @has_a ||= find_has_a(args) 
    end

    def is_base_role?
      has_a.tag_list_on(:base_role).include?('true')
    end

    def related_as
      role.name
    end

    def people_that_relate_as_role_to_destroy
      @people_that_relate_as_role_to_destroy ||= people_that_relate_as(args)
    end

    def new_organization
      BigbeeGraph::Organization.new(id: organization_id)
    end

end
