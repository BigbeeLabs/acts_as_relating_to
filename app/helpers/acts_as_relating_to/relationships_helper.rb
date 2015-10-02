module ActsAsRelatingTo
  module RelationshipsHelper
  	def relate_to(options={})
  		puts "in #{self.class}.#{__method__}"
  		owner = controller_constant.find(params["#{controller_name.singularize}_id"])
  		related_thing = params[:thing_type].camelize.constantize.find(params[:thing_id])
  		params[:as] ? (owner.relate_to related_thing, as: params[:as]) : (owner.relate_to related_thing)
  		head :ok
  	end
  end
end
