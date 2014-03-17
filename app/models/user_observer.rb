class UserObserver < ActiveRecord::Observer

  def before_save(user)
    if user.new_record?
      encrypt_confirmation_code(user)
      JobVacancy.deliver(:registration, :registration_email, user.name, user.email)
    end
  end

  def after_save(user)
    deliver(:confirmation, :confirmation_email, user.name,
                       user.email,
                       user.id,
                       user.confirmation_code) unless user.confirmation
  end

  private
  def encrypt_confirmation_code(user)
    user.confirmation_code = set_confirmation_code(user)
  end

  def set_confirmation_code(user)
    require 'bcrypt'
    salt = BCrypt::Engine.generate_salt
    confirmation_code = BCrypt::Engine.hash_secret(user.password, salt)
    normalize_confirmation_code(confirmation_code)
  end

  def normalize_confirmation_code(confirmation_code)
    confirmation_code.gsub("/", "")
  end
end
