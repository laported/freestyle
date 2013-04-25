require 'nokogiri'
require 'open-uri'  

class DataProviders::TeamManagerDbProxy
  AthleteQuery = "http://www.sports-tek.com/TMOnline/aATHLETE.asp?aGroup=&SubGroup=&Class=&SEX=&TEAM=&thePage=1&PageSize=2000&SEARCH=%s&DB=%s"
  #MI_SWIM_DB   = "upload%5CMichiganSwimmingLSCOfficeCopy.mdb"
  # At the start of the 2013 short course season, the URL chnaged to this funky one:
  # (%7B = '}' ???? )
  MI_SWIM_DB   = "upload%5CMichiganSwimmingLSC%7B.mdb"
  #define MISCA_SWIM_DB "upload%5CMHSAAMISCAOfficeCopy.mdb"

  def test_url
    doc = Nokogiri::HTML(open(AthleteQuery % [ 'LaPorte', MI_SWIM_DB]))
    doc.css("table[summary=Athletes] tr")
  end
  
  def search_by_name(last,first)
    url_query = AthleteQuery % [ last, MI_SWIM_DB]
    
    doc = Nokogiri::HTML(open(url_query))
  end
end