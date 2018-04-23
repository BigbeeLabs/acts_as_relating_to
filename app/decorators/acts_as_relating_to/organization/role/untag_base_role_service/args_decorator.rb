class ActsAsRelatingTo::Organization::Role::UntagBaseRoleService::ArgsDecorator < ActsAsRelatingTo::DecoratorBase

  dig_for organization: [:id], role: [:id]

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

  private

end
