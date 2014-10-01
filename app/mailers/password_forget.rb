JobVacancy::App.mailer :password_forget do
  email :password_forget_email do |user, link|
    from "admin@job-vacancy.de"
    subject "Password reset"
    to user.email
    locals :name => user.name, :link => link
    render 'password_forget/password_forget_email'
  end
end

