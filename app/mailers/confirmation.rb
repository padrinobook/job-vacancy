##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# and then all delivered mail will use these settings unless otherwise specified.
#

JobVacancy.mailer :confirmation do

  # Find a better way to get into the main URL of the application ...
  # Padrino.root prints me out the path instead of the URL
  CONFIRMATION_URL = "http://localhost:3000/confirm"

  email :confirmation_email do |name, email, id, link|
    from "test@test.de"
    subject "Please confirm your account"
    to email
    locals :name => name, :confirmation_link => "#{CONFIRMATION_URL}/#{id}/#{link}"
    render 'confirmation/confirmation_email'
  end
end
