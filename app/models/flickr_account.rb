class FlickrAccount

    delegate :photos_url,
             :to => :info

    def initialize(uid, limit)
        @account = Flickr.people.find(uid)
        @sets = @account.get_sets
        @limit = limit
    end


    def info
        @info ||= @account.get_info!
    end


    def profile_pic_url
        @profile_pic_url ||= "http://farm#{info.icon_farm}.staticflickr.com/#{info.icon_server}/buddyicons/#{info.nsid}.jpg"
    end


    def set_from_name(name)
        @sets.find(name)
    end


    def default_set
        @sets.first
    end


    def sized_photos_from_set(set, size = 'large1024_or_smaller!')
        sized_photos(set.get_photos(sizes: :all), size)
    end


    def photos_from_stream(size = 'large1024_or_smaller!')
        sized_photos(@account.get_public_photos(sizes: :all))
    end


    def sized_photos(photos, size = 'large1024_or_smaller!')
        photos.map { |photo| photo.send(size) }
    end


    def sets
        @wrapped_sets ||= @sets.first(@limit).map do |set|
            FlickrSet.new(set.title, set.id)
        end
    end


    class FlickrSet < Struct.new(:title, :id)
    end

end