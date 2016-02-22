class ScoreDaily
  include Mongoid::Document
  include Mongoid::Timestamps
  field :score, type: Integer
  field :createdAt, type: DateTime
  
  attr_accessor :score, :createdAt
end
