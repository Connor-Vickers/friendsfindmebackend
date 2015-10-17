class PeopleController < ApplicationController
	def index
    	@persons = Person.all
  	end
	
	def new
		@person = Person.new
	end

	def edit
		@person = Person.find(params[:format])
	end

	def create
		@person = Person.new(person_params)
		@person.save
		redirect_to @person
	end

	def update
		@person = Person.find(params[:format])
		@person.update(person_params)
		redirect_to @person
	end

	def show
    	@person = Person.find(params[:format])
  	end

	private
  		def person_params
    		params.require(:person).permit(:number, :long, :lat)
  		end
end
