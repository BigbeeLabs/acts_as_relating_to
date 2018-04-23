class <%= class_name %>::<%= manager_name.to_s.camelize %> < <%= ENV['app_name'].camelize %>::ManagerBase
  class << self

  private

  end # Class Methods

  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def manage
      super
    end

  private

end
