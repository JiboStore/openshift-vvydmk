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
  
  def submitscoredaily
    userid = params[:userid]
    #userid = session[:userid]
    userExist = User.where(fbid: userid).first
    if ( userExist == nil ) then
      response = {:code => 403, :message => "forbidden access"}
      logger.debug "scoredaily/submitscoredaily : unable to find user: " + userid
      render json: response.to_json, status: 403 and return
    end
    #scoreDateTime = Time.parse(params[:scoredate]) # 2016-03-07 00:00:00 +0800
    scoreDate = Date.parse(params[:scoredate]) # 2016-03-07
    scoreObject = Scoredaily.where(fbid: userid, scoreDate: scoreDate).first
    if ( scoreObject == nil ) then
      scoreObject = Scoredaily.new(fbid: userid, scoreDate: scoreDate)
      scoreObject.createdAt = Time.now.to_s
    end
    logger.debug "scoreObject exist: #{scoreObject}"
    scoreObject.updatedAt = Time.now.to_s
    scoreObject.score = params[:score]
    scoreObject.save
    logger.debug scoreObject.to_s
    render json: scoreObject
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
