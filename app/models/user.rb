class User < ActiveRecord::Base

  attr_accessible :urlname, :about, :links_attributes, :limit

  has_many :links, :dependent => :destroy
  accepts_nested_attributes_for :links

  validates_uniqueness_of :urlname
  validates_format_of :urlname, :with => /^[A-Za-z\d_]+$/
  validates_length_of :about, :maximum => 140

  class << self
    def create_with_omniauth(auth)
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

  # TODO: Make this a column for users to select other layouts!
  def portfolio_style
    'application'
  end

  def url
    "http://#{self.urlname}.rgb.io"
  end

  def flickr_account
    @flickr_account ||= FlickrAccount.new(uid, limit)
  end

end
