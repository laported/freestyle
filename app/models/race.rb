class Race < ActiveRecord::Base
  belongs_to :swimmer
  belongs_to :sanctioning_body
  belongs_to :meet
  attr_accessible :distance, :place, :points, :standard_achieved, :stroke, :time
end
