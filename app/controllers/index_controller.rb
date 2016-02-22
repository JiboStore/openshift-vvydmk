class IndexController < ApplicationController
  def index
    #@checkConnection = check_mongoid_connection
    @totalCount = ScoreDaily.count
    @onehourCriteria = ScoreDaily.where(score: 60)
  end
  
  def check_mongoid_connection
          Rails.logger.debug("check_mongoid_connection 00")
          mongoid_config = File.read("#{Rails.root}/config/mongoid.yml")
           Rails.logger.debug("check_mongoid_connection 01")
          config = YAML.load(mongoid_config)[Rails.env].symbolize_keys
          host, db_name, user_name, password = config[:host], config[:database], config[:username], config[:password]
          port = config[:port] || Mongo::Connection::DEFAULT_PORT

          Rails.logger.debug("check_mongoid_connection 02")
          
          #db_connection = Mongo::Connection.new(host, port).db(db_name)
          db_connection = MongoClient.new('127.0.0.1', 27017)
          
           Rails.logger.debug("check_mongoid_connection 03")
          db_connection.authenticate(user_name, password) unless (user_name.nil? || password.nil?)
           Rails.logger.debug("check_mongoid_connection 04")
          db_connection.collection_names
           Rails.logger.debug("check_mongoid_connection 05")
          return "ok"
          #return { status: :ok }
      rescue Exception => e
          #return { status: :error, data: { message: e.to_s } }
          #return "failed"
          #return "#{e.backtrace.first}: #{e.message} (#{e.class})", e.backtrace.drop(1).map{|s| "\t#{s}"}
          return e.message
  end
      
end
