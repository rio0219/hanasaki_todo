class Goal < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :daily_records
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank
end
