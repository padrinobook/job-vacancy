class User < ActiveRecord::Base
  has_many :job_offers
end
