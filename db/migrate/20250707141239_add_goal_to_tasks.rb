class AddGoalToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :goal, null: true, foreign_key: true
  end
end
