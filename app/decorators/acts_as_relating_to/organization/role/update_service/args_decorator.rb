class ActsAsRelatingTo::Organization::Role::UpdateService::ArgsDecorator < ActsAsRelatingTo::DecoratorBase

  dig_for organization: [:id], role: [:id]
  #==============================================================================================
  # Instance Methods
  #==============================================================================================

  private

end