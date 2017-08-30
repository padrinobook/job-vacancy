JobVacancy::App.mailer :password_reset do
  email :email do |user, link|
    from 'admin@job-vacancy.de'
    subject 'Password reset'
    to user.email
    locals name: user.name, link: link
    render 'password_reset/email'
  end
end

