class PortfolioPage

    PHOTO_SIZE = 'large1024'

    attr_reader :photos, :navbar

    def initialize(user, params)
        @user = user
        @account = @user.flickr_account
        @photos = determine_photos(@account, params)
        @navbar = Navbar.new(user)
    end


private #######################################################################


    def determine_photos(account, params)
        set      = determine_set(account, params)
        photos   = account.sized_photos_from_set(set, ideal_size) unless set.nil?
        photos ||= account.sized_photos_from_stream(account)
    end


    def determine_set(account, params)
        account.set_from_name(params[:set_id]) or account.default_set
    end


    def ideal_size
        @ideal_size ||= "#{PHOTO_SIZE}_or_smaller!"
    end

end