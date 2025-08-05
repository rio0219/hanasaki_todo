class Task < ApplicationRecord
  belongs_to :goal
  has_many :task_records, dependent: :destroy
end
