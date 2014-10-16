JobVacancy::App.mailer :password_reset do
  email :password_reset_email do |user, link|
    from "admin@job-vacancy.de"
    subject "Password reset"
    to user.email
    locals :name => user.name, :link => link
    render 'password_reset/password_reset_email'
  end
end

