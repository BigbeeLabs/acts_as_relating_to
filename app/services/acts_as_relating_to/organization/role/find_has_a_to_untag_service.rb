class ActsAsRelatingTo::Organization::Role::FindHasAToUntagService < ActsAsRelatingTo::ServiceBase

  SERVICE_DETAILS = [
    
  ].freeze

  REQUIRED_ARGS = %w(
    
  ).freeze

  REQUIRED_VALUES = %w(
    
  ).freeze

  delegate *%w(
    
  ), to: :decorated_args
  
  #==============================================================================================
  # Instance Methods
  #==============================================================================================

    def call
      puts "#{self.class}.#{__method__}, args:"<<" #{args}".red
      raise unless good_to_go?
    end

  private

end
