require 'securerandom'

class User < ActiveRecord::Base
  include JobVacancy::String::Normalizer

  validates :name, presence: true,
                   uniqueness: true

  validates :password, length: { minimum: 5 },
                       presence: true,
                       confirmation: true

  validates :confirmation_token, presence: true

  before_create :generate_authentity_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }

  has_many :job_offers

  def authenticate(token)
    @user = User.find_by_id(self.id)

    if @user && @user.confirmation_token == token
      self.confirmation = true
      self.save
      return true
    end

    false
  end

  def save_forget_password_token
    self.password_reset_token = generate_authentity_token
    self.password_reset_sent_date = Time.now
    self.save
  end

  private

  def generate_authentity_token
    self.authentity_token = normalize(SecureRandom.base64(64))
  end
end

