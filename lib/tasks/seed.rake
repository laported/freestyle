require 'nokogiri'
require 'open-uri'  
require 'RaceTime'

namespace :seed do
  desc "init the database"
  task :init => :environment do

    sb = SanctioningBody.find(:first, :conditions => "name = 'USA Swimming'")
    if sb.nil?
      sb = SanctioningBody.new
      sb.name = "USA Swimming"
      sb.save!
    end

    d = DataProvider.find(:first, :conditions => "name = 'TeamStats Online'")
    if d.nil?
      d = DataProvider.new
      d.name = "TeamStats Online"
      d.root_url = "http://www.sports-tek.com/TMOnline"
      d.sanctioning_body_id = sb.id
      d.save!
    end
  
    s = Swimmer.find(:first, :conditions => "first = 'Benjamin' and last = 'LaPorte'")
    if s.nil?
      s = Swimmer.new
      s.first = "Benjamin"
      s.last  = "LaPorte"
      s.dob   = "2000-01-29"
      s.save!
    end
  
    key = SwimmerIdKey.find(:first, :conditions => 'swimmer_id = ' + s.id.to_s )
    if key.nil?
      key = SwimmerIdKey.new
      key.swimmer_id = s.id
      key.data_provider_id = d.id
      key.key = "11655"
      key.save!
    end
  
  end

  desc "fetch race data"
  task :fetch_races => :environment do

    online = false
    
    swimmers = Swimmer.find(:all)
    swimmers.each do |swimmer|
      puts swimmer.last + "," + swimmer.first 
      providers = swimmer.data_providers.find(:all)
      providers.each do |provider|
        if provider.name == 'TeamStats Online'
          # Y = Short course yards
          # L = Long course meters
          # S = Short course meters
          ['Y','L','S'].each do |course|
            key = provider.swimmer_id_keys.find(:first, :conditions => 'swimmer_id = ' + swimmer.id.to_s)
    	      url_all = "http://www.sports-tek.com/TMOnline/aATHRESULTSWithPSMR.ASP?db=upload%5CMichiganSwimmingLSCOfficeCopy.mdb&ATH=" + key.key + "&FASTEST=&PageSize=2000&COURSE=" + course
            puts "  " + provider.name + " KEY: " + key.key
            if online
              doc = Nokogiri::HTML(open(url_all))
            else
              if course == 'L'
                doc = Nokogiri::HTML(File.open("/Users/laported/dev/rails/scrapemi1/test/files/test-all-long.html"))
              elsif course == 'Y'
                doc = Nokogiri::HTML(File.open("/Users/laported/dev/rails/scrapemi1/test/files/test-all.html"))
              else
                doc = Nokogiri::HTML(File.open("/Users/laported/dev/rails/scrapemi1/test/files/test-all-scm.html"))
              end
            end
            doc.css("table[summary=Results] tr").each do |row|
              cols = row.css("td")
              if (cols[1] != nil)
                splits    = cols[0].css("a")[0][:onclick].split("'")[1] #.attributes['onclick'] #[:onclick] #.text #.css("a")
                distance  = cols[1].text[/[0-9\.]+/].to_i
                ym        = cols[1].text[/[Y|M]/]
                stroke    = cols[2].text
                pf        = cols[3].text
                time      = RaceTime::to_seconds(cols[4].text)
                place     = cols[5].text.to_i
                points    = cols[6].text.to_i
                date      = cols[7].text
                meet_name_s = Meet.sanitize(cols[8].text)
                meet_name = cols[8].text
    
                meet = Meet.find(:first, :conditions => "name = " + meet_name_s)
                if meet.nil?
                  meet = Meet.new
                  meet.name  = meet_name
                  meet.start = date.to_date
                  meet.end   = date.to_date
                  meet.course = (course == 'Y') ? 'SCY' : ((course == 'L') ? 'LCM' : 'SCM')
                  meet.save!
                  puts "--> New Meet: " + meet.name
                end

                race = Race.find(:first, :conditions => 'meet_id = ' + meet.id.to_s + 
                   " and stroke = '" + stroke + "'" + 
                   " and distance = " + distance.to_s +
                   " and time = " + time.to_s)
                if race.nil?
                  race = Race.new
                  race.stroke              = stroke
                  race.distance            = distance
                  race.time                = time
                  race.place               = place
                  race.points              = points
                  race.swimmer_id          = swimmer.id
                  race.meet_id             = meet.id
                  race.sanctioning_body_id = provider.sanctioning_body_id
                  race.save!
                  puts "--> New race"
                end
                        
                puts "    #{meet.name} / " + meet.course + " / " + meet.start.to_s
                puts "      #{race.distance} #{race.stroke}  #{race.time}" 
                puts "        Splits: #{splits}"
    
              end  
            end
          end 
        end 
      end 
    end  
  end 
  
end
