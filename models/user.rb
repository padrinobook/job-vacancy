class User < ActiveRecord::Base
  before_save :encrypt_confirmation_code, :if => :registered?

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

  def authenticate(confirmation_code)
    return false unless @user = User.find_by_id(self.id)

    if @user.confirmation_code == self.confirmation_code
      true
    else
      false
    end
  end

  private
  def encrypt_confirmation_code
    self.confirmation_code = set_confirmation_code
  end

  def set_confirmation_code
    require 'bcrypt'
    salt = BCrypt::Engine.generate_salt
    confirmation_code = BCrypt::Engine.hash_secret(self.password, salt)
    normal_confirmation_code(confirmation_code)
  end

  def registered?
    self.new_record?
  end

  def normal_confirmation_code(confirmation_code)
    confirmation_code.gsub("/", "")
  end

end
