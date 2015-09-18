require "acts_as_relating_to/engine"

module ActsAsRelatingTo
	def acts_as_relating_to(*classes_array)
		class_eval do

			# ========================================================================
			#  Callbacks
			# ========================================================================
				before_destroy :tell_to_unrelate

			# ========================================================================
			#  Associations
			# ========================================================================
				has_many :owned_relationships,
					as: :owner,
					class_name: "ActsAsRelatingTo::Relationship",
					dependent: :destroy
																			 
				has_many :referencing_relationships,
					as: :in_relation_to,
					class_name: "ActsAsRelatingTo::Relationship",
					dependent: :destroy
	
			
				classes_array.each do |class_sym|
					has_many (class_sym.to_s + "_i_relate_to").to_sym,
								through: :owned_relationships, 
								source: :in_relation_to, 
								source_type: class_sym.to_s.singularize.camelize 
					
					has_many (class_sym.to_s + "_that_relate_to_me").to_sym,					
								through: :referencing_relationships, 
								source: :owner, 
								source_type: class_sym.to_s.singularize.camelize
	
					define_method("owned_relationships_to_" + class_sym.to_s) do
						owned_relationships.where(in_relation_to_type: "#{class_sym.to_s.singularize.camelize}")
					end		
					
				end #classes_array.each do |class_sym|			
			end
		include InstanceMethods
		extend ClassMethods
	end
	
	module InstanceMethods

		#===========================================================================
  	def create_relationship(args)
			Relationship.create(owner: args[:owner], in_relation_to: args[:in_relation_to])
  	end
  	
		#===========================================================================
		def tell_to_unrelate
			puts "in #{self.class.name}.#{__method__}"
  		@relating_things = referencing_relationships.map{|rel| rel.owner_type}.uniq
  		@relating_things.each do |thing|
  			thing.constantize.unrelate_to(in_relation_to_type: self.class.name, in_relation_to_id: self.id)
  		end
		end

		#===========================================================================
  	def relate_to(related_thing, options={})
  		puts "in #{self.class.name}.#{__method__}"
  		puts "options.inspect: #{options.inspect}"
			unless @relationship = relationship_to(related_thing).first
				puts "no relationship"
				@relationship = Relationship.create!(owner: self, in_relation_to: related_thing)
			else
				puts "relationship is there"
			end
			unless options[:as].nil?
				puts "options[:as].nil?: #{options[:as].nil?}"
				@relationship.role_list.add options[:as]
				@relationship.save
			end
		end

		#===========================================================================
  	def relates_to?(thing)
  		(relationship_to(thing).count > 0)? true : false
  	end 

		#===========================================================================
  	def relates_to_as?(thing, role)
  		relationship_to(thing).tagged_with(role).count > 0
  	end
  
		#===========================================================================
  	def relationship_to(thing)
  		# CUSTOM_LOGGER.info "in #{self.class.name}.#{__method__}"
  		owned_relationships.where(in_relation_to_id: thing.id, in_relation_to_type: thing.class.name)
  	end
  	
  	def unrelate_to(thing)
  		puts "in #{self.class.name}.#{__method__}"
  		puts "this is the intance method"
  		rel = relationship_to(thing).first
  		puts "rel.inspect: #{rel.inspect}"
  	end

	end #Instance Methods
	
	module ClassMethods
		
		def unrelate_to(options={})
			puts "in #{self}.#{__method__}"
  		thing = options[:in_relation_to_type].constantize.find(options[:in_relation_to_id])
  		rels = Relationship.where(owner_type: self,	in_relation_to: thing)
  		rels.each do |rel|
  			object = self.find(rel[:owner_id])
  			object.unrelate_to(thing)
  		end
		end
	end #ClassMethods
	
end

ActiveRecord::Base.extend ActsAsRelatingTo
