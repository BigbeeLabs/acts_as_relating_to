class ActsAsRelatingTo::Organization::Role::AutoassignPeopleService::ArgsDecorator < ActsAsRelatingTo::DecoratorBase

  dig_for organization: [:id], role: [:id]

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

  private

end