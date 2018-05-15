RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
require File.dirname(__FILE__) + '/factories'
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/helpers/**/*.rb')].each(&method(:require))

# require 'simplecov'
# SimpleCov.start do
#   add_group "Models", "app/models"
#   add_group "Controllers", "app/controllers"
#   add_group "Helpers", "app/helpers"
#   add_group "Mailers", "app/mailers"
# end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include FactoryBot::Syntax::Methods
  conf.mock_framework = :rspec
  conf.full_backtrace = false # save the console
  conf.color = true # save your eyes
  conf.formatter = :documentation
  # conf.filter_run focus: true

  # custom test filter
  # then use your test in the following way
  # it "stay on page if user is not found", :current do
  # ...
  # end
  # conf.filter_run :current
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app JobVacancy::App
#   app JobVacancy::App.tap { |a| }
#   app(JobVacancy::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

def cookies_from_response(response = last_response)
  Hash[response["Set-Cookie"].lines.map { |line|
    cookie = Rack::Test::Cookie.new(line.chomp)
    [cookie.name, cookie]
  }]
end
