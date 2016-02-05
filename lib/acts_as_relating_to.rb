require "acts_as_relating_to/engine"
#require 'acts_as_relating_to/relationship'

module ActsAsRelatingTo
	def acts_as_relating_to(*classes_array)
    #puts "in #{my_klass}.#{__method__}, classes_array: #{classes_array}"
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
					define_method(class_sym.to_s + "_that_relate_to_me") do |options={}|
						if options[:as]
							ids = referencing_relationships.tagged_with(options[:as]).where("owner_type=?", class_sym.to_s.singularize.camelize).map{|t| t.owner_id}
							class_sym.to_s.singularize.camelize.constantize.find(ids)
						else
							ids = referencing_relationships.where("owner_type=?", class_sym.to_s.singularize.camelize).map{|t| t.owner_id}
							class_sym.to_s.singularize.camelize.constantize.find(ids)
						end
					end

					define_method(class_sym.to_s+"_i_relate_to") do |options={}|
						if options[:as]
							ids = owned_relationships.tagged_with(options[:as]).where("in_relation_to_type=?", class_sym.to_s.singularize.camelize).map{|t| t.in_relation_to_id}
							class_sym.to_s.singularize.camelize.constantize.find(ids)
						else
							ids = owned_relationships.where("in_relation_to_type=?", class_sym.to_s.singularize.camelize).map{|t| t.in_relation_to_id}
							class_sym.to_s.singularize.camelize.constantize.find(ids)
						end
					end

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
  	def create_relationship(owner,in_relation_to)
			Relationship.create!(
        owner_type:           owner.class,
        owner_id:             owner.id,
        in_relation_to_type:  in_relation_to.class,
        in_relation_to_id:    in_relation_to.id
      )
  	end
  	
		#===========================================================================
		def tell_to_unrelate
			referencing_relationships.each do |referencing_relationship|
				referencing_relationship.owner.unrelate_to self
			end
		end

		#===========================================================================
		# TODO Able to accept either string or array for options[:as]
		#===========================================================================
  	def relate_to(related_thing, options={})
			unless @relationship = relationship_to(related_thing).first
				@relationship = create_relationship self, related_thing
			end
			unless options[:as].nil?
				@relationship.role_list.add options[:as]
				@relationship.save
			end
		end

		#===========================================================================
  	def relates_to?(thing)
  		relationship_to(thing).count > 0
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
  		relationship_to(thing).first.destroy!
  	end

	end #Instance Methods
	
	module ClassMethods
=begin		
		def unrelate_to(options={})
			puts "in #{self}.#{__method__}"
  		thing = options[:in_relation_to_type].constantize.find(options[:in_relation_to_id])
  		rels = Relationship.where(owner_type: self,	in_relation_to: thing)
  		rels.each do |rel|
  			object = self.find(rel[:owner_id])
  			object.unrelate_to(thing)
  		end
		end
=end
	end #ClassMethods
	
end

ActiveRecord::Base.extend ActsAsRelatingTo
