class User < ActiveRecord::Base
  validates :name, :email, :password, :presence => true
  validates :name, :uniqueness => true
  validates :email, :uniqueness => true

  has_many :job_offers
end
