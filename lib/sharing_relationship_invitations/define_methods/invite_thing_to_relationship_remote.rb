module SharingRelationshipInvitations
  module DefineMethods
    module InviteThingToRelationshipRemote
      def define_method_invite_thing_to_relationship_remote(class_sym, options={})
        klass_name = options[:class_name] || class_sym.singularize.camelize
        klass = klass_name.constantize
        singular = class_sym.to_s.singularize


        define_method("invite_#{singular}_to_relationship_url") do 
          @url = app_provider.url.clone
          self.class.name.demodulize.downcase.pluralize.tap do |x|
            @url << "/#{x}/#{self.id}"
          end
          @url << "/sent_relationship_invitations"
          append_query
        end

        define_method("invite_#{singular}_to_relationship") do |thing, query=nil|
          @query = query || {}
          @query[:as] ||= :friend
          @query[:thing_type] = klass_name.demodulize.camelize
          @query[:thing_id] = thing.id
          @thing = thing
          if thing.is_a?(klass)
            @called_by = __method__.to_s
            generic('post').tap do |remote_result|
              puts "remote_result:"<<" #{remote_result}".light_blue
              return remote_result
            end
          end
        end

        

        private



      end
    end
  end
end