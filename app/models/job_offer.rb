class JobOffer < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, :location, :contact, presence: true

  validate :dates

  private
  def dates
    if time_start.blank?
      errors.add(:time_start, 'bla')
    end
  end
end

