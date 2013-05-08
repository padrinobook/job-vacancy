class User < ActiveRecord::Base
  validates :name, :presence => true,
                   :uniqueness => true

  validates :password, :length => {:minimum => 5},
                       :presence => true,
                       :confirmation => true


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { with: VALID_EMAIL_REGEX }

  validates :confirmation_code, :presence => true

  has_many :job_offers

  def authenticate(confirmation_code)
    return false unless @user = User.find_by_id(self.id)

    if @user.confirmation_code == confirmation_code
      self.confirmation = true
      self.save
      true
    else
      false
    end
  end

end
