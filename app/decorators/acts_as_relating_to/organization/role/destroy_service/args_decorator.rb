class ActsAsRelatingTo::Organization::Role::DestroyService::ArgsDecorator < ActsAsRelatingTo::DecoratorBase

  dig_for organization: [:id], role: [:id]

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

  private

end
