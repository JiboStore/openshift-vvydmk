require 'date'
require 'time'

class ScoredailyController < ApplicationController
  def save
  end

  def retrieve
  end
  
  def calculatescoreformonth
    #userid = params[:userid]
    userid = session[:userid]
    userExist = User.where(fbid: userid).first
    if ( userExist == nil ) then
      response = {:code => 403, :message => "forbidden access"}
      logger.debug "scoredaily/calculatescoreformonth : unable to find user #{userid}"
      #render :json => response.to_json, :status => 403 and return #this_is_fine_too
      render json: response.to_json, status: 403 and return
    end
    dateInMonth = Date.parse(params[:datemonth])
    dateStart = dateInMonth.at_beginning_of_month
    dateEnd = dateInMonth.end_of_month
    logger.debug "scoredaily/calculatescoreformonth: #{dateStart} - #{dateEnd}"
    winMine = 0
    winEnemy = 0
    totalMine = 0
    totalEnemy = 0
    scoresMine = Scoredaily.where(fbid: userExist.fbid, scoreDate: {'$gte' => dateStart, '$lte' => dateEnd}).all
    scoresEnemy = Scoredaily.where(fbid: userExist.competitorFbid, scoreDate: {'$gte' => dateStart, '$lte' => dateEnd}).all
    (dateStart..dateEnd).each do |date|
      myscore = nil
      enemyscore = nil
      scoresMine.each do |s|
        if ( s.scoreDate == date ) then
          myscore = s
          break
        end
      end
      scoresEnemy.each do |s|
        if ( s.scoreDate == date ) then
          enemyscore = s
          break
        end
      end
      
      mscore = myscore == nil ? 0 : myscore.score
      escore = enemyscore == nil ? 0 : enemyscore.score
      if ( mscore > escore ) then
        winMine += 1
      elsif ( mscore < escore ) then
        winEnemy += 1
      end
      totalMine += mscore
      totalEnemy += escore    
    end
=begin
    scoresMine.each do |myscore|
      enemyScorePresent = false
      scoresEnemy.each do |enemyscore|
        if myscore.scoreDate == enemyscore.scoreDate then
          if myscore.score > enemyscore.score
            winMine += 1
          elsif myscore.score < enemyscore.score
            winEnemy += 1
          else
          end
          totalMine += myscore.score
          totalEnemy += enemyscore.score
        end
      end
    end
=end
    logger.debug "scoredaily/calculatescoreformonth: #{winMine} vs #{winEnemy} = #{totalMine} vs #{totalEnemy}"
    render :json => scoresMine
=begin
    dateLow = Date.parse("2016-03-06")
    dateHigh = Date.parse("2016-03-09")
    #scoresInMonth = Scoredaily.where(:scoreDate => {'$gte' => dateLow, '$lt' => dateHigh}).all #this_is_ok
    #scoresInMonth = Scoredaily.where(fbid: userid, scoreDate: {'$gte' => dateLow, '$lt' => dateHigh}).all #this_is_ok_too
    #render json: params
    render json: scoresInMonth
    #render :json => params
=end
  end
  
  def submitscoredaily
    #userid = params[:userid]
    userid = session[:userid]
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

=begin
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
=end
    
end
