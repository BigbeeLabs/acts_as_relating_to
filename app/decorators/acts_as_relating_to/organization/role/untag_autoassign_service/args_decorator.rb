class ActsAsRelatingTo::Organization::Role::UntagAutoassignService::ArgsDecorator < ActsAsRelatingTo::DecoratorBase

  dig_for organization: [:id], role: [:id]

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

  private

end
