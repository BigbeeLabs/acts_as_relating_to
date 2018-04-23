class <%= class_name %>::ManagerBase < <%= ENV['app_name'].camelize>::ManagerBase
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
