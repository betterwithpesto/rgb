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

	if @current_set != nil
		@photos = @current_set.get_photos(sizes: :all).map{ 
			|photo| 
			if (!(photo.large!(1024).source_url.nil?))
				photo.large!(1024)
			else 
				photo.largest!
			end}
	else
		@photos = @person.get_public_photos(sizes: :all).map{ 
			|photo| 
			if (!(photo.large!(1024).source_url.nil?))
				photo.large!(1024)
			else 
				photo.largest!
			end}
	end	
	#@person.get_public_photos(sizes: :all).map(&:large1024!).first(10)
end

def edit
	@user = User.find_by_urlname!(request.subdomain)
	
end

def update
	@user = User.find_by_urlname!(request.subdomain)
	if User.where(:urlname => params[:urlname]).first.nil?
		if @user.update_attributes(params[:user])
			redirect_to signout_url(:subdomain => false)
	end		
	else
		redirect_to signout_url(:subdomain => false)
	end
end

end