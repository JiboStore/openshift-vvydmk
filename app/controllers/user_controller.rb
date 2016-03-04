class Pojo
  @fbid
  
  attr_accessor :fbid
end

class UserController < ApplicationController
  
  def fblogin
    userExist = User.where(fbid: params[:fbid]).first
    if ( userExist == nil ) then
      #render :text => "User does not exist"
      userExist = User.new(:fbid => params[:fbid], :facebookname => params[:facebookname])
      #userExist.initwithparams(:fbid => params[:fbid], :facebookname => params[:facebookname])
    end
    if ( params.has_key?(:facebookname) ) theb
      userExist.facebookname = params[:facebookname]
    end
    if ( params.has_key?(:competitorFbid) ) then
      userExist.competitorFbid = params[:competitorFbid]
    end
    if ( params.has_key?(:accessToken) ) then
      userExist.accessToken = params[:accessToken]
    end
    userExist.updatedAt = Time.now.to_s
    userExist.runCount = userExist.runCount == nil ? 0 : userExist.runCount + 1
    userExist.save
    session[:userid] = userExist.fbid #keep current userid in session
    #logger.debug "userExist => #{userExist.to_yaml}"
    #logger.debug "userExist => #{userExist.to_s}"
    #logger.debug "session => #{session[:userid]}"
    #logger.debug "session => #{session.to_yaml}" # can't dump anonymous module
    logger.debug "userExist => #{userExist.writeasjson}"
    logger.debug "userExist => #{session[:userid]}"
    render :json => userExist
    #render :text => session[:userid]
  end
  
  def fbchangecompetitor
    userExist = session[:userid] == nil ? nil : User.where(fbid: session[:userid]).first
    if ( userExist == nil ) then
      # unauthorized
      response = {:code => 403, :message => "forbidden access"}
      logger.debug "user/fbchangecompetitor : unable to find user"
      render json: response.to_json, status: 403 and return
    elsif ( params[:competitorFbid] == nil ) then
      response = {:code => 404, :message => "invalid param"}
      logger.debug "user/fbchangecompetitor : invalid param"
      #render :json => response.to_json, status: 403 and return #this_is_also_ok: :json => response.to_json, status: 403
      render json: response.to_json, status: 403 and return
    end
    userExist.competitorFbid = params[:competitorFbid]
    userExist.save
    logger.debug "userExist => #{userExist.writeasjson}"
    render json: userExist.to_json
    #render :text => userId
  end
  
  def fblogin_fortest
    #@userparam = User.new :fbid => params[:fbid], :facebookname => params[:facebookname], :competitorFbid => params[:competitorFbid]
    ##@pojo = Pojo.new
    ##@pojo.fbid = "566020605"
    ## render :json => @pojo #ok
    #render :json => @userparam.writeasjson
    #userExist = User.where(fbid: params[:fbid]).all.to_a
    #render :json => userExist[0].writeasjson
    
=begin
      userExistCriteria = User.where(fbid: params[:fbid])
      userMe = userExistCriteria.each do | me |
        userHash = {
          :fbid => me.fbid, 
          :facebookname => me.facebookname, 
          :competitorFbid => me.competitorFbid, 
          :createdAt => me.createdAt,
          :updatedAt => me.updatedAt
        }
        #render :json => userHash  
      end
      userId = userExistCriteria.first
      userCriteria = User.find(userId.id)
      render :json => userCriteria
=end
    
    # this one is working
    # http://stackoverflow.com/a/35686889/474330
    #userSearchCriteria = User.find_by(fbid: params[:fbid])
    #userSearchCriteria = User.where(fbid: params[:fbid]).first
    userSearchCriteria = User.where(:fbid.ne => nil).first
    @result = User.where(fbid: params[:fbid]).first
    #render :json => userSearchCriteria      
    #@result = userSearchCriteria
    
  end
end
