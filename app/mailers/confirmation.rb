JobVacancy::App.mailer :confirmation do
  # Find a better way to get into the main URL of the application ...
  # Padrino.root prints me out the path instead of the URL
  CONFIRMATION_URL = "http://localhost:3000/confirm"

  email :confirmation_email do |name, email, id, link|
    from "admin@job-vacancy.de"
    subject "Please confirm your account"
    to email
    locals :name => name, :confirmation_link => "#{CONFIRMATION_URL}/#{id}/#{link}"
    render 'confirmation/confirmation_email'
  end
end

