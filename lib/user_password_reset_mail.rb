class UserPasswordResetMail
  attr_accessor :user, :app

  def initialize(user, app = JobVacancy::App)
    @user = user
    @app ||= app
  end

  def reset_mail(link)
    @app.deliver(
      :password_reset,
      :email,
      @user,
      link
    )
  end
end

