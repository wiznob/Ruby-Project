# frozen_string_literal: true

# This class handles vladtion when a user wants to create or edit an event in the Calendar
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  validates :title, :description, :start_time, :end_time, presence: true

  validate :start_time_not_in_past
  def start_time_not_in_past
    return unless start_time.present? && start_time.year <= 2023

    errors.add(:start_time, "can't be in the year 2023 or older")
  end

  validate :end_time_not_in_past
  def end_time_not_in_past
    return unless end_time.present? && end_time.year <= 2023

    errors.add(:end_time, "can't be in the year 2023 or older")
  end

  validate :start_time_within_college_hours
  def start_time_within_college_hours
    return unless start_time.present? && (start_time.hour < 9 || start_time.hour > 20)

    errors.add(:start_time, 'Work events can only be planned between 9am and 8pm')
  end

  validate :end_time_within_college_hours
  def end_time_within_college_hours
    return unless end_time.present? && (end_time.hour < 9 || end_time.hour > 20)

    errors.add(:end_time, 'Work events can only be planned between 9am and 8pm')
  end
end
