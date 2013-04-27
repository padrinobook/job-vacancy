PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.dirname(__FILE__) + "/factories"

RSpec.configure do |conf|
  conf.before do
    User.observers.disable :all # <-- turn of user observers for testing reasons
  end
  conf.mock_with :rspec
  conf.include Rack::Test::Methods
  conf.include FactoryGirl::Syntax::Methods
  conf.full_backtrace= false # save the console
  conf.color_enabled= true   # save your eyes
  conf.formatter = :documentation
end

# don't send mails during testing
Mail.defaults do
  delivery_method :test
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  JobVacancy.tap { |app|  }
end
