class Goal < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :daily_records
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank
  def self.update_streak_counts
    all.find_each do |goal|
      last_record = goal.daily_records.order(date: :desc).first
      if last_record&.date == Date.yesterday
        goal.increment!(:streak_count)
      else
        goal.update!(streak_count: 0)
      end
    end
  end

  def self.record_zero_for_unchecked_goals
    today = Date.current
    all.find_each do |goal|
      next if goal.daily_records.where(date: today).exists?

      goal.daily_records.create!(date: today, count: 0)
    end
  end
end
