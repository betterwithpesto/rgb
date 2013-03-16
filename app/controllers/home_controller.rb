class HomeController < ApplicationController
	def index
		person = Flickr.people.find(current_user.uid)
    	@photos = person.get_public_photos(sizes: :all).map(&:large1024!)
	end
end