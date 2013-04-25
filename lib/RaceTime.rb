module RaceTime 

  def RaceTime.to_seconds(str_time)
    hours = 0
    minutes = 0
    seconds = 0
    ms = 0
    
    hms = str_time.split(":")
    i = 0
    if hms.length == 3
      hours = hms[i].to_i
      i = i + 1
    elsif hms.length >= 2
      minutes = hms[i].to_i
      i = i + 1
    end
    
    sms = hms[hms.length-1].split(".")
    seconds = sms[0].to_i
    ms = sms.length == 2 ? sms[1].to_i : 0
    
    ndecimals = sms.length == 2 ? sms[1].length : 1
    
    hours*60.0*60.0 + minutes*60.0 + seconds + ms/(10.0**ndecimals)
  end

  def self.pad(x)
    if x < 10
      '0' + x.to_s
    else
      x.to_s
    end
  end
  
  def RaceTime.to_string(f_time)
    i_time = f_time.truncate()
    hours = i_time / 3600
    minutes = (i_time / 60) % 60
    seconds = (i_time - minutes*60)
    
    frac = ((f_time - (hours*3600 + minutes*60 + seconds)).round(2) * 100).truncate
    if hours > 0
      "#{hours}:#{pad(minutes)}:#{pad(seconds)}.#{frac}"
    elsif minutes > 0
      "#{minutes}:#{pad(seconds)}.#{frac}"
    else 
      "#{seconds}.#{frac}"
    end
  end

end
