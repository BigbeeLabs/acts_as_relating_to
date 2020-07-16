Gem::Specification.find_by_name("acts_as_relating_to").gem_dir.tap do |gem_dir|
  Dir["#{gem_dir}/lib/acts_as_related_to_by/class_methods/*.rb"].each do |f|
    require_dependency f
    f.split('/').last.split('.').first.camelize.tap do |module_name|
      #puts "in " << "#{self.class.name}.#{__method__}".white << ", " << "module_name: " << "#{module_name}".yellow
      include "ActsAsRelatedToBy::ClassMethods::#{module_name}".constantize
    end
  end
end

Gem::Specification.find_by_name("acts_as_relating_to").gem_dir.tap do |gem_dir|
  Dir["#{gem_dir}/lib/acts_as_related_to_by/class_methods/acts_as_related_to_by/*.rb"].each do |f|
    require_dependency f
  end
end

module ActsAsRelatedToBy
  module ClassMethods

      def is_array_of_keys?(array)
        array.all?{|x| x.is_a? Symbol}
      end
    
  end
end