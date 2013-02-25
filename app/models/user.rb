class User < ActiveRecord::Base
	attr_accessible :urlname, :about
   def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.urlname = user.uid.gsub("@", "").downcase
    end
  end
end
