require 'RaceTime'

module ApplicationHelper  
  def format_time(ftime)
    RaceTime::to_string(ftime)
  end
end
