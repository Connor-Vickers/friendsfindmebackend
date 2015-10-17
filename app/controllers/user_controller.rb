class UserController < ApplicationController
	def index
    	@users = User.all
  	end

  	def set
  		#if not user make and then save
  		user = User.find_by(number: params[:number])
  		if (user == nil){
  			user = User.new(user_params)
  		}else{
  			user.update(user_params)
  		}
  		render nothing: true
  	end

  	def get
  	end

  	private
  		def user_params
    		params.permit(:number, :long, :lat)
  		end
end
