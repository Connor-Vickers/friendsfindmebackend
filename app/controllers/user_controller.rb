class UserController < ApplicationController
	def index
    	@users = User.all
  	end

  	def get
  		#if not user make and then save
  		
  		user = User.find_by(number: params[:number])
  		if (user == nil)
  			user = User.new(user_params)
  			user.save();
  		else
  			user.update(user_params)
  		end

  		if (params[:friends] != nil)
  			friends = JSON.parse(params[:friends])
  		else
  			friends = []
  		end

  		ret = {}
  		for i in (0..friends.length) do
  			friend = User.find_by(number: friends[i].to_i)
  			if (friend != nil)
				ret[friend.number] = [get_dir(user,friend), get_dist(user,friend)]
			end
  		end
  		render json: ret.to_json
  	end

  	def get2
  		#if not user make and then save
  		
  		user = User.find_by(number: params[:number])
  		if (user == nil)
  			user = User.new(user_params)
  			user.save();
  		else
  			user.update(user_params)
  		end

  		if (params[:friends] != nil)
  			friends = JSON.parse(params[:friends])
  		else
  			friends = []
  		end

  		if (friends.length > 0)
  			shortestFriend = User.find_by(number: friends[0].to_i)
	  		shortestDist = get_dist(user,shortestFriend)
	  		for friendnumber in friends do
	  			friend = User.find_by(number: friendnumber.to_i)
	  			if (friend != nil && get_dist(user,friend) < shortestDist)
					shortestFriend = friend
				end
	  		end
	  		#todo if angle less than certain distance
	  		angle = get_dir(user,shortestFriend) * (180/(2*3.14159))
	  	else
	  		angle = -1
	  	end
  		render plain: "[" + "degrees:" + angle.to_s + "]"
  	end

  	private
  		def user_params
    		params.permit(:number, :long, :lat)
  		end

  		def get_dir(you,them)
  			return Math.atan2(them.lat-you.lat, them.long-you.long)
  		end

  		def get_dist(you,them)
  			return Math.sqrt(((them.lat-you.lat)**2)+((them.long-you.long)**2))
  		end
end
