class User < ActiveRecord::Base
	attr_accessible :urlname, :about
	validates_uniqueness_of :urlname
	validates_format_of :urlname, :with => /^[A-Za-z\d_]+$/
  has_many :links, :dependent => :destroy
  accepts_nested_attributes_for :links

   def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]

      if Flickr.people.find(user.uid).get_info!.path_alias.nil?
    		user.urlname = user.uid.gsub("@", "").downcase
      else
     		user.urlname = Flickr.people.find(user.uid).get_info!.path_alias.downcase
    	end
    end
  end
end
