class User < ActiveRecord::Base
  before_save :encrypt_confirmation_code

  validates :name, :presence => true,
                   :uniqueness => true

  validates :password, :length => {:minimum => 5},
                       :presence => true,
                       :confirmation => true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { with: VALID_EMAIL_REGEX }

  has_many :job_offers

  def confirmation_code
    require 'bcrypt'
    salt = BCrypt::Engine.generate_salt
    confirmation_code = BCrypt::Engine.hash_secret(self.password, salt)
    confirmation_code
  end

  private
  def encrypt_confirmation_code
    self.confirmation_code = confirmation_code
  end

end
