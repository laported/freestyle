class SwimmerController < ApplicationController
  
  #define MI_SWIM_DB    "upload%5CMichiganSwimmingLSCOfficeCopy.mdb"
  #define MISCA_SWIM_DB "upload%5CMHSAAMISCAOfficeCopy.mdb"
  
  def index
    @swimmers = Swimmer.find(:all)
  end
  
  # get_handle
  # ----------
  # Parameters:
  # last: last name
  # first: first name
  #
  # Given a swimmer's last name and first name, this function will return the 
  # database id of the swimmer
  #
  def get_handle
    logger.debug "Hoo ha!"
    s = Swimmer.find(:all, :conditions => "last = '#{params[:last]} and first like '#{params[:first]}'").map {er|x| x.id }
    respond_to do |format|
      json { render s.to_json }
    end
  end
  
  #
  # lookup
  #
  # Parameters
  # params[:last]  - required
  # params[:first] - optional
  #
  # Returns
  # 
  def lookup_new_swimmer
    
  end
end
