class IndexController < ApplicationController
  def index
    @scoredaily = ScoreDaily.where(score: 60)
  end
end
