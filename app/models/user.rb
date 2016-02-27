class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fbid, type: String
  field :facebookname, type: String
  field :competitorFbid, type: String
  field :createdAt, type: DateTime
  field :updatedAt, type: DateTime
  
  attr_accessor :fbid, :facebookname, :competitorFbid, :createdAt, :updatedAt
end
