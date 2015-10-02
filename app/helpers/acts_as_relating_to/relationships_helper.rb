module ActsAsRelatingTo
  module RelationshipsHelper
  	def relate_to(options={})
  		puts "in #{self.class}.#{__method__}"
  		owner = controller_constant.find(params["#{controller_name.singularize}_id"])
  		related_thing = params[:thing_type].camelize.constantize.find(params[:thing_id])
  		params[:as] ? (owner.relate_to related_thing, as: params[:as]) : (owner.relate_to related_thing)
  		head :ok
  	end

  	def i_relate_to
			puts "in #{self.class}.#{__method__}, params: #{params}"
  		owner = controller_constant.find(params["#{controller_name.singularize}_id"])
  		if params[:as]
  			things = owner.send "#{params[:thing_type]}_#{__method__}", as: params[:as]
  		else
  			things = owner.send "#{params[:thing_type]}_#{__method__}"
  		end
  		puts "things: #{things.inspect}"
  		ret = things.map{|t| [id: t.id, name: t.name, system_name: t.system_name]}
  		render json: things, status: :ok
  	end
  end
end
