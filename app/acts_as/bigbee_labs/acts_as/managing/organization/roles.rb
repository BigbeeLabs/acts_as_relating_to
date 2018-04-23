module BigbeeLabs::ActsAs::Managing::Organization::Roles

  module ClassMethods
    
  end
  
  module InstanceMethods

    def update_organization_role(args={})
      call_service ActsAsRelatingTo::Organization::Role::UpdateService
    end

    def destroy_organization_role(args={})
      puts "#{self.class}.#{__method__}, args:"<<" #{args}".green
      call_service ActsAsRelatingTo::Organization::Role::DestroyService
    end
    
  end
  
  def self.included(receiver)
    receiver.extend  ClassMethods
    receiver.include InstanceMethods
  end
end