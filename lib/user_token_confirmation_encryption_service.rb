require 'bcrypt'

class UserTokenConfirmationEncryptionService
  include JobVacancy::String::Normalizer

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def encrypt_confirmation_token
    salt = BCrypt::Engine.generate_salt
    token = BCrypt::Engine.hash_secret(@user.password, salt)
    @user.confirmation_token = normalize(token)
  end
end

