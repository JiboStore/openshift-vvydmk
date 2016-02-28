class Pojo
  @fbid
  
  attr_accessor :fbid
end

class UserController < ApplicationController
  def fblogin
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
    
    
    userSearchCriteria = User.find_by(fbid: params[:fbid])
    render :json => userSearchCriteria      
    
  end
end
