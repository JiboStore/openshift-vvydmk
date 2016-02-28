require 'pp'
require 'json'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  #field :_id, type: String, default: ->{ name } # which was `key :name` before v3
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
  
  def writeasjson
    #JSON.parse(@self.to_json(:everything))
    #@fbid
    hash = { :fbid => @fbid, 
      :facebookname => @facebookname, 
      :competitorFbid => @competitorFbid, 
      :createdAt => @createdAt,
      :updatedAt => @updatedAt
    }
    hash.to_json
  end
  
  attr_accessor :fbid, :facebookname, :competitorFbid, :createdAt, :updatedAt
end
