class HomeController < ApplicationController
	def index
		person = Flickr.people.find("25777376@N05")
    	@photos = person.get_public_photos(sizes: :all).map(&:large640!)
	end
end
