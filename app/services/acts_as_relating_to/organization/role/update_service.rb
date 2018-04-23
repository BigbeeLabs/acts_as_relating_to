class ActsAsRelatingTo::Organization::Role::UpdateService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    {organization: [:id]},
    {role: [:id]},
    :is_base_role,
    :autoassign,
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
  
  use_peer_service_for  :tag_autoassign,
                        :tag_base_role,
                        :untag_autoassign,
                        :untag_base_role,
                        :update_base_role

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      raise unless good_to_go?
      puts "#{self.class}.#{__method__}, args:"<<" #{args}".green
      if process_base_role?
        update_base_role if is_base_role
        untag_base_role unless is_base_role
      end
      unless autoassign.nil?
        autoassign ? tag_autoassign : untag_autoassign
      end
    end

  private

    def process_base_role?
      !is_base_role.nil?
    end

end