class ActsAsRelatingTo::Organization::Role::TagAutoassignService::ArgsDecorator < ActsAsRelatingTo::DecoratorBase

  dig_for organization: [:id], role: [:id]

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

  private

end
