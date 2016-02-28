class Pojo
  @fbid
  
  attr_accessor :fbid
end

class UserController < ApplicationController
  def fblogin
    @userparam = User.new :fbid => params[:fbid], :facebookname => params[:facebookname], :competitorFbid => params[:competitorFbid]
    @pojo = Pojo.new
    @pojo.fbid = "566020605"
    # render :json => @pojo #ok
    render :json => @userparam.writeasjson
  end
end
