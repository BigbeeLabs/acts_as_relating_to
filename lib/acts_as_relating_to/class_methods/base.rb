module ActsAsRelatingTo
  module ClassMethods
    module Base
      def acts_as_relating_to_base(class_sym, options={})
        if self < ActiveRecord::Base
          ar_has_many
        else
          poro_has_many :owned_relationships,
            as: :owner,
            class_name: "ActsAsRelatingTo::Relationship",
            dependent: :destroy
                                         
          poro_has_many :referencing_relationships,
            as: :in_relation_to,
            class_name: "ActsAsRelatingTo::Relationship",
            dependent: :destroy          
        end
        methods_to_define = [
          "things_i_relate_to",
          "add_thing",
          "things"
        ]
        methods_to_define.each do |method_name|
          send "define_method_#{method_name}", class_sym, options
        end
        
      end
    end
  end
end