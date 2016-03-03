#require 'pp'
require 'json'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  #field :_id, type: String, default: ->{ name } # which was `key :name` before v3
  field :fbid, type: String
  field :facebookname, type: String
  field :competitorFbid, type: String
  field :accessToken, type: String
  field :runCount, type: Integer
  field :createdAt, type: String
  field :updatedAt, type: String
  
  # cannot use constructor because self is not available yet and write_attribute cannot be called as well
=begin
  def initwithparams(options={})
    self.fbid = options.fetch(:fbid, '')
    self.facebookname = options.fetch(:facebookname, '')
    self.competitorFbid = options.fetch(:competitorFbid, '')
  end
=end
  
  # building constructor the rails way: http://stackoverflow.com/a/3214293/474330
  # default value for params: http://stackoverflow.com/a/4554397/474330
  def initialize(options = {})
    super()
    if ( options != nil ) then
      self.fbid = options.fetch(:fbid, '')
      self.facebookname = options.fetch(:facebookname, '')
      self.competitorFbid = options.fetch(:competitorFbid, '')
      self.accessToken = options.fetch(:accessToken, '')
      self.runCount = 0
      # all the following ways are ok! for more info: https://mongoid.github.io/en/mongoid/docs/documents.html#dynamic_fields
      #write_attribute(:fbid, options.fetch(:fbid, ''))
      #write_attribute(:fbid, '12')
      #self[:fbid] = options.fetch(:fbid, '')
      #self[:facebookname] = options.fetch(:facebookname, '')
      #self[:competitorFbid] = options.fetch(:competitorFbid, '')
    end
    self.createdAt = Time.now.to_s
    self.updatedAt = Time.now.to_s
    # self.createdAt = Time.now.to_s # no, no! unless you called super()
    # self[:updatedAt] = Time.now.to_s # no, no, no! unless you called super()
  end
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
    hash = { :fbid => self.fbid, 
      :facebookname => self.facebookname, 
      :competitorFbid => self.competitorFbid, 
      :accessToken => self.accessToken,
      :createdAt => self.createdAt,
      :updatedAt => self.updatedAt
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
