class Navbar

    delegate :about, :links,
             :to => :@user

    delegate :sets, :profile_pic_url, :photos_url,
             :to => :@account

    def initialize(user)
        @user = user
        @account = user.flickr_account
    end

end