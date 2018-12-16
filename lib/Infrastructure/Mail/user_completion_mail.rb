class UserCompletionMail

  attr_accessor :user, :app

  def initialize(user, app = JobVacancy::App)
    @user = user
    @app ||= app
  end

  def send_registration_mail
    @app.deliver(
      :registration,
      :registration_email,
      @user.name,
      @user.email
    )
  end

  def send_confirmation_mail
    @app.deliver(
      :confirmation,
      :confirmation_email,
      @user.name,
      @user.email,
      @user.id,
      @user.confirmation_token
    )
  end
end

