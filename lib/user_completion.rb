class UserCompletion
  require 'bcrypt'

  attr_accessor :user, :app

  def initialize(user, app)
    @user = user
    @app = app
  end

  def send_registration_mail
    self.app.deliver(:registration, :registration_email, self.user.name, self.user.email)
  end

  def send_confirmation_mail
    self.app.deliver(:confirmation, :confirmation_email, user.name,
      user.email,
      user.id,
      user.confirmation_code) unless user.confirmation
  end

  def encrypt_confirmation_code
    salt = BCrypt::Engine.generate_salt
    confirmation_code = BCrypt::Engine.hash_secret(self.user.password, salt)
    self.user.confirmation_code = confirmation_code
  end
end
