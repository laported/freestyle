class SwimmerIdKey < ActiveRecord::Base
  attr_accessible :dataprovider_id, :key, :swimmer_id
  belongs_to :swimmer
  belongs_to :data_provider
end
