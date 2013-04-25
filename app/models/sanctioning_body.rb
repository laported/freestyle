class SanctioningBody < ActiveRecord::Base
  attr_accessible :name
  has_many :data_providers
end
