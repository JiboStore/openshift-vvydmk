class IndexController < ApplicationController
  def index
    @totalCount = ScoreDaily.count
    @onehourCriteria = ScoreDaily.where(score: 60)
  end
end
