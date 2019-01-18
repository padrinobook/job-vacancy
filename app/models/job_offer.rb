class JobOffer < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, :location, :contact, presence: true

  private
  def dates
    if time_start.blank? || time_end.blank?
      errors.add(:time_start, 'bla')
    end

    if time_start && time_end && time_start > time_end
      errors.add(:time_end, 'must be after time_start')
    end
  end
end

