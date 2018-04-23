class ActsAsRelatingTo::ServiceBase
  include BigbeeLabs::ActsAs::IncludingModules
  
  include_modules bigbee_labs: {
    acts_as: [
      :service, 
      {calling: [
        :services
        ]
      }
    ]
  }

end