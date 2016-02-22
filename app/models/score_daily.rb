class ScoreDaily
  include Mongoid::Document
  include Mongoid::Timestamps
  field :score, type: Integer
  
  attr_accessor :score
end
