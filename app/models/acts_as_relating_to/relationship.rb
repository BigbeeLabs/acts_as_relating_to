module ActsAsRelatingTo
  class Relationship < ActiveRecord::Base
		
		# ==========================================================================
		#  Validations
		# ==========================================================================
			validates :owner_id,     							presence: true
			validates :owner_type,   							presence: true
			validates :in_relation_to_id,   			presence: true
			validates :in_relation_to_type, 			presence: true
			
		# ==========================================================================
		#  Associations
		# ==========================================================================
			belongs_to  :owner,	polymorphic: true
			belongs_to  :in_relation_to,    	polymorphic: true
		
		# ==========================================================================
		#  ActsAs Modules
		# ==========================================================================
  	acts_as_taggable
  	acts_as_taggable_on :roles
  	
  end
end
