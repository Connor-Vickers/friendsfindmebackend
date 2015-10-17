class UserController < ApplicationController
	def index
    	@users = User.all
  	end

  	def get
  		#if not user make and then save
  		
  		user = User.find_by(number: params[:number])
  		logger.debug "user"
  		logger.debug user
  		if (user == nil)
  			logger.debug "is nil"
  			user = User.new(user_params)
  			user.save();
  		else
  			user.update(user_params)
  			logger.debug "is not"
  		end
  		render nothing: :true
  	end

  	private
  		def user_params
    		params.permit(:number, :long, :lat)
  		end
end
