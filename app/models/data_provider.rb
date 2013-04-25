class DataProvider < ActiveRecord::Base
  belongs_to :sanctioning_body
  attr_accessible :name, :root_url
  has_many :swimmer_id_keys
  has_many :swimmers, :through => :swimmer_id_keys
end
