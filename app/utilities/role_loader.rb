class RoleLoader

  class << self

    def load_all
      new.load_all
    end

  end # Class Methods

  # ==========================================================================
  #  Instance Methods
  # ==========================================================================

    def load_all
      Rails.root.join('db','seeds','acts_as_relating_to','roles','**','*.yaml').tap do |path|
        Dir["#{path}"].sort{|a,b| a <=> b}.each do |file|
          @spec = YAML.load_file(file).with_indifferent_access
          load_spec
        end
      end
    end

  private

    def spec()        @spec                                   end
    def role()        @role ||= find_role                     end
    def role_name()   spec[:role][:name]                      end

    def update?
      role and (spec[:headers].nil? or !spec[:headers][:delete])
    end

    def delete?
      role and spec[:headers] and spec[:headers][:delete]
    end

    def create?
      !role and (spec[:headers].nil? or !spec[:headers][:delete])
    end

    def load_spec
      delete if delete?
      update if update?
      create if create?
    end
    
    def find_role
      ActsAsRelatingTo::Role.find_by(name: role_name)
    end

    def create
      role = ActsAsRelatingTo::Role.new(spec[:role])
      if role.save
        puts "  ActsAsRelatingTo::Role with name: " << spec[:role][:name].blue << " was " << "saved.".green
      else
        puts "  ActsAsRelatingTo::Role with name: " << spec[:role][:name].blue << " was " << "NOT saved.".red
      end
    end

    def delete
      if role.destroy
        puts "  ActsAsRelatingTo::Role with name: " << spec[:role][:name].blue << " was " << "destroyed.".green
        @role = nil
      end
    end

    def update
      role.assign_attributes spec[:role]
      if role.changed?
        if role.save
          puts "  ActsAsRelatingTo::Role with name: " << spec[:role][:name].blue << " was " << "updated.".green
        else
         puts "  ActsAsRelatingTo::Role with name: " << spec[:role][:name].blue << " was " << "NOT saved.".red
        end
      else 
        puts "  ActsAsRelatingTo::Role with name: " << spec[:role][:name].blue << " was " << "NOT saved".green << " (no changes)."
      end
    end

end