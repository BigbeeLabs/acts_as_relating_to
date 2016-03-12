module ActsAsRelatingTo
  module DefineMethods
    module ThingsIRelateTo
      def define_method_things_i_relate_to(class_sym, options={})
        puts "in #{self}.#{__method__}, class_sym: #{class_sym}"
        puts "in #{self}.#{__method__}, options: #{options}"

        define_method(class_sym.to_s+"_i_relate_to") do |options={}|
          if options[:as]
            ids = owned_relationships.tagged_with(options[:as]).where("in_relation_to_type=?", class_sym.to_s.singularize.camelize).map{|t| t.in_relation_to_id}
            class_sym.to_s.singularize.camelize.constantize.find(ids)
          else
            ids = owned_relationships.where("in_relation_to_type=?", class_sym.to_s.singularize.camelize).map{|t| t.in_relation_to_id}
            class_sym.to_s.singularize.camelize.constantize.find(ids)
          end
        end
                
      end
    end
  end
end