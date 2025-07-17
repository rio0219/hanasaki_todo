class AddStreakCountToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :streak_count, :integer, default: 0, null: false
  end
end
