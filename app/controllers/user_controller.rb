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
    userExist.updatedAt = Time.now.to_s
    userExist.runCount = userExist.runCount == nil ? 0 : userExist.runCount + 1
    userExist.save
    render :json => userExist
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
