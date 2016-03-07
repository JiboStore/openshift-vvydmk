require 'date'
require 'time'

class ScoredailyController < ApplicationController
  def save
  end

  def retrieve
  end
  
  def calculatescoreformonth
    render :json => params
  end
  
  def calculatemonthly
    userid = params[:userid]
    #userid = session[:userid]
    userExist = User.where(fbid: userid).first
    if ( userExist == nil ) then
      response = {:code => 403, :message => "forbidden access"}
      logger.debug "scoredaily/calculatemonthly : unable to find user"
      render json: response.to_json, status: 403 and return
    end
    
    timeStart = Time.new(params[:year], params[:month]) # 2016-03-01
    timeEnd = timeStart.end_of_month
    #timeEnd = Time.new(params[:year], params[:month], -1)
    #timeEnd = timeStart.utc.end_of_month  # 2016-03-31
    #dateStart = DateTime.parse(params[:year] + params[:month] + "01")
    render :json => timeEnd
    
    #render :json => params
  end
  
end
