class UserController < ApplicationController
  def fblogin
    @userparam = User.new :fbid => params[:fbid], :facebookname => params[:facebookname], :competitorFbid => params[:competitorFbid]
  end
end
