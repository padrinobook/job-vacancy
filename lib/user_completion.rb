class UserCompletion
  require 'bcrypt'
  include StringNormalizer

  attr_accessor :user, :app

  def initialize(user, app = JobVacancy::App)
    @user = user
    @app ||= app
  end

  def send_registration_mail
    self.app.deliver(:registration, :registration_email, self.user.name, self.user.email)
  end

  def send_confirmation_mail
    self.app.deliver(:confirmation, :confirmation_email, user.name,
      user.email,
      user.id,
      user.confirmation_code)
  end

  def encrypt_confirmation_code
    salt = BCrypt::Engine.generate_salt
    confirmation_code = BCrypt::Engine.hash_secret(self.user.password, salt)
    self.user.confirmation_code = normalize(confirmation_code)
  end
end
