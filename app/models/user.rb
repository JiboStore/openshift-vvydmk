require 'pp'
require 'json'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  #field :_id, type: String, default: ->{ name } # which was `key :name` before v3
  field :fbid, type: String
  field :competitorFbid, type: String
  field :createdAt, type: String
  field :updatedAt, type: String
  
  # building constructor the rails way: http://stackoverflow.com/a/3214293/474330
=begin
  def initialize(options = {})
    if ( options != nil ) then
      @fbid = options[:fbid]
      @facebookname = options[:facebookname]
      @competitorFbid = options[:competitorFbid]
    end
  end
=end
  
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
  
  # this is the problem!
  # http://stackoverflow.com/questions/35679841/mongoid-criteria-result-doesnt-fill-all-field
  #attr_accessor :fbid, :competitorFbid, :createdAt, :updatedAt
  #attr_accessor :fbid
  #attr_accessor :competitorFbid
  #attr_accessor :createdAt
  #attr_accessor :updatedAt
end
