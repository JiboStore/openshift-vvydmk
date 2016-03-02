class ScoreDaily
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fbid, type: String
  field :score, type: Integer
  field :createdAt, type: String
  field :updatedAt, type: String
end
