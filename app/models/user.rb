class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fbid, type: String
  field :facebookname, type: String
  field :competitorFbid, type: String
  field :createdAt, type: DateTime
  field :updatedAt, type: DateTime
  
  # building constructor the rails way: http://stackoverflow.com/a/3214293/474330
  def initialize(options = {})
    @fbid = options[:fbid]
    @facebookname = options[:facebookname]
    @competitorFbid = options[:competitorFbid]
  end
  
  attr_accessor :fbid, :facebookname, :competitorFbid, :createdAt, :updatedAt
end
