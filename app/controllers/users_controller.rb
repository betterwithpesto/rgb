class UsersController < ApplicationController

def show
	@user = User.find_by_urlname!(request.subdomain)
	@person = Flickr.people.find(@user.uid)
	@sets = @person.get_sets
	#@default_set = @sets.first.id

	

	if params[:set_id] != nil
		@current_set = @sets.find(params[:set_id])
	else
		@current_set = @sets.first
	end

	@photos = @current_set.get_photos(sizes: :all).map(&:large1024!)
	#@person.get_public_photos(sizes: :all).map(&:large1024!).first(10)
end

def edit
	@user = User.find_by_urlname!(request.subdomain)
	
end

def update
	@user = User.find_by_urlname!(request.subdomain)
	if @user.update_attributes(params[:user])
		redirect_to signout_url(:subdomain => false)
	end
end

end