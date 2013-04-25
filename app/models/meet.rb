class Meet < ActiveRecord::Base
  attr_accessible :course, :end, :location, :name, :start
end
