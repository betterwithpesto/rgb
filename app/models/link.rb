class Link < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :url
end
