class UsersController < ApplicationController

def show
	@user = User.find_by_urlname!(request.subdomain)
	@person = Flickr.people.find(@user.uid)
	@photos = @person.get_public_photos(sizes: :all).map(&:large1024!).first(10)

	@sets = @person.get_sets
end

end
