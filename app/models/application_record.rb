class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  validates :title, :description, :start_time, :end_time, presence: true

  validate :start_time_not_in_past
  def start_time_not_in_past
    if start_time.present? && start_time.year <= 2023
      errors.add(:start_time, "can't be in the year 2023 or older")
    end
  end

  validate :end_time_not_in_past
  def end_time_not_in_past
    if end_time.present? && end_time.year <= 2023
      errors.add(:end_time, "can't be in the year 2023 or older")
    end
  end

  validate :start_time_within_college_hours
  def start_time_within_college_hours
    if start_time.present? && (start_time.hour < 9 || start_time.hour > 20)
      errors.add(:start_time, "Work events can only be planned between 9am and 8pm")
    end
  end

  validate :end_time_within_college_hours
  def end_time_within_college_hours
    if end_time.present? && (end_time.hour < 9 || end_time.hour > 20)
      errors.add(:end_time, "Work events can only be planned between 9am and 8pm")
    end
  end
end
