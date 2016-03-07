class ScoredailyController < ApplicationController
  def save
  end

  def retrieve
  end
  
  def calculatescoreformonth
    render :json => params
  end
end
