class ActsAsRelatingTo::Organization::Role::AutoassignPeopleService < ActsAsRelatingTo::ServiceBase

  REQUIRED_VALUES = %w(
    organization_id
    role_id
    token
  ).freeze

  attr_accessor *%w(
    related_as
    people_with_autoassign_role_name
    people_with_current_base_role_name
  ).freeze

  delegate *%w(
    organization_id
    role_id    
  ), to: :decorated_args
  
  use_peer_service_for  :current_base_role_name,
                        :people_that_relate_as

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      raise unless @role = find_role
      raise unless @organization = new_organization
      puts "#{self.class}.#{__method__}, people_to_autoassign:"<<" #{people_to_autoassign}".green
      people_to_autoassign.each do |person|
        person.using_credential(token: token).relate_to_organization organization, as: autoassign_role_name
      end
    end

  private

    def people_to_autoassign
      set_people_collections
      @people_to_autoassign ||= get_people_to_autoassign
    end

    def get_people_to_autoassign
      people_with_current_base_role_name.select{|p| !people_ids_with_autoassign_role_name.include?(p.id)}
    end

    def set_people_collections
      [:autoassign_role_name, :current_base_role_name].each do |role_type|
        @related_as = send(role_type)
        instance_variable_set("@people_with_#{role_type}", people_that_relate_as(args))
      end
    end

    def people_ids_with_autoassign_role_name
      people_with_autoassign_role_name.map(&:id)
    end

    def autoassign_role_name
      role.name
    end

    def find_role
      ActsAsRelatingTo::Role.find_by(id: role_id)
    end

    def new_organization
      BigbeeGraph::Organization.new(id: organization_id)
    end

end
