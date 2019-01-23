class JobOffer < ActiveRecord::Base
  belongs_to :user

  validates :title,
    :description,
    :location,
    :contact,
    :time_start,
    :time_end,
    presence: true

  validate :dates

  private
  def dates
    if time_start && time_end && time_start > time_end
      errors.add(:time_end, 'must be after time_start')
    end
  end
end

