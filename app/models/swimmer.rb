class Swimmer < ActiveRecord::Base
  attr_accessible :dob, :first, :last
  has_many :races
  has_many :swimmer_id_keys
  has_many :data_providers, :through => :swimmer_id_keys
  
  def short_course_races
    Race.find(:all,
      :joins => "join meets on meet_id = meets.id",
      :conditions => "swimmer_id = " + id.to_s + " and meets.course = 'SCY'")
  end
  
  def long_course_meters_races
    Race.find(:all,
      :joins => "join meets on meet_id = meets.id",
      :conditions => "swimmer_id = " + id.to_s + " and meets.course = 'LCM'")
  end
  
  def short_course_meters_races
    Race.find(:all,
      :joins => "join meets on meet_id = meets.id",
      :conditions => "swimmer_id = " + id.to_s + " and meets.course = 'SCM'")
  end
  
end
