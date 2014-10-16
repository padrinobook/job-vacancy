JobVacancy::App.mailer :registration do
  WELCOME_PDF = "#{Padrino.root}/app/assets/pdfs/welcome.pdf"

  email :registration_email do |name, email|
    from "admin@job-vacancy.de"
    subject "Welcome!"
    to email
    locals :name => name, :email => email
    render 'registration/registration_email'
    add_file :filename => 'welcome.pdf', :content => File.open(WELCOME_PDF) { |f| f.read }
  end
end

