PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.dirname(__FILE__) + "/factories"
Dir[File.dirname(__FILE__) + '/../app/helpers/**.rb'].each { |file| require file }

RSpec.configure do |conf|
  conf.mock_with :rspec
  conf.include Rack::Test::Methods
  conf.include FactoryGirl::Syntax::Methods
  conf.full_backtrace= false # save the console
  conf.color_enabled= true   # save your eyes
  conf.formatter = :documentation

  ActiveRecord::Base.observers.disable :all # => Turn them all off
end

# Have access to the session variables.
def session
  last_request.env['rack.session']
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  JobVacancy::App.tap { |app|  }
end
