class UsersController < ApplicationController

def show
	@user = User.find_by_urlname!(request.subdomain)
	@person = Flickr.people.find(@user.uid)
	@sets = @person.get_sets
	#@default_set = @sets.first.id
	@profile_pic_url = "http://farm" << @person.get_info!.icon_farm.to_s << ".staticflickr.com/" << @person.get_info!.icon_server.to_s << "/buddyicons/" << @person.get_info!.nsid << ".jpg"

	@photo_size = 1024

	if params[:set_id] != nil
		@current_set = @sets.find(params[:set_id])
	else
		@current_set = @sets.first
	end

	if @current_set != nil
		@photos = @current_set.get_photos(sizes: :all).map{ 
			|photo| 
			if (!(photo.large!(@photo_size).source_url.nil?))
				photo.large!(@photo_size)
			else 
				photo.largest!
			end}
	else
		@photos = @person.get_public_photos(sizes: :all).map{ 
			|photo| 
			if (!(photo.large!(@photo_size).source_url.nil?))
				photo.large!(@photo_size)
			else 
				photo.largest!
			end}
	end
	@photos = @photos.take 10

	@total_width = 0
	@max_height = @photos.map {|p| p.height}.min
	@photos.each do |pic|
		@total_width += pic.width
	end
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