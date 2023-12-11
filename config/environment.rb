# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
# Rails.logger = Logger.new(Rails.root.join("log", Rails.env + ".log"))
Rails.logger = Logger.new(("log/#{Rails.env}.log"))
Rails.logger.level = Logger::DEBUG
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"

Rails.logger.formatter = proc do |severity, datetime, progname, msg|
    "#{datetime} | #{severity} | #{progname} | #{msg}"
end 

Rails.logger.info("Environment: #{Rails.env}") do 
    "Rails logger started"
end