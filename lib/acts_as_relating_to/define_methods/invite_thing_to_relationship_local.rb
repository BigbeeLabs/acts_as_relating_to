module ActsAsRelatingTo
  module DefineMethods
    module InviteThingToRelationshipLocal

      def define_method_invite_thing_to_relationship_local(class_sym, options={})
        klass_name = options[:class_name] || class_sym.to_s.singularize.camelize
        klass = klass_name.constantize
        singular = class_sym.to_s.singularize

        define_method("invite_#{singular}_to_relationship") do |thing, args={}|
          puts "#{self.class}.#{__method__}, thing.inspect:"<<" #{thing.inspect}".green
          if thing.is_a?(klass)
            role_list = args[:as] || ["friend"]
            role_list = role_list.split(" ") unless role_list.is_a?(Array)
            role_list.each do |role_name|
              puts "#{self.class}.#{__method__}, role_name:"<<" #{role_name}".green
              ActiveRecord::Base.transaction do
                if role = ::ActsAsRelatingTo::Role.find_by(name: role_name)
                  puts "#{self.class}.#{__method__}, role.inspect:"<<" #{role.inspect}".green
                  unless invitation = relationship_invitations_sent_to(thing).where(role_id: role.id).first
                    invitation = sent_relationship_invitations.new(recipient: thing, role_id: role.id)
                    if invitation.save
                      puts "#{self.class}.#{__method__}, invitation.inspect:"<<" #{invitation.inspect}".green
                    else
                      return {errors: invitation.errors.full_messages}
                    end
                  else 
                    puts "#{self.class}.#{__method__}, "<<"already exists".red
                  end
                else
                  @error = "'#{role_name}' is not a recognized role."
                  raise ActiveRecord::Rollback
                end
              end
            end
          else
            @error = "expected a #{klass_name} but got a #{thing.class.name}"
          end
          return {error: @error} if @error
          true
        end
        
      end

    end
  end
end