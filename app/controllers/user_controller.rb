class UserController < ApplicationController
	def index
    	@users = User.all
  	end

  	def get
  		ret = get_angle()
  		
  		render plain: "{\""+ret[0].to_s+"\":"+ret[1].round.to_s+"}"
  	end

  	def get2
  		#get_angle()
  		render plain: ((get_angle()[1]+90)/22.5).round.to_s
  		#render plain: 4
  	end

  	private
  		def get_angle
			user = User.find_by(number: params[:number])
			logger.warn "params"
			logger.warn params
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

	  		logger.warn "friends"
			logger.warn friends

	  		shortestFriend = nil
	  		for friendnumber in friends do
		  		friend = User.find_by(number: friendnumber.to_i)
		  		if (friend != nil)
					shortestFriend = friend
				end
		  	end

		  	logger.warn "starting friends"
			logger.warn shortestFriend

	  		if (friends.length > 0 && shortestFriend != nil)
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

		  	if shortestFriend != nil
		  		number = shortestFriend.number
		  	else
		  		number = 0
		  	end

		  	logger.warn "number"
			logger.warn number
			logger.warn "angle"
			logger.warn angle

		  	return [number,angle]
  		end

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
