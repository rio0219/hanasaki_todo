class AddUserIdToGoals < ActiveRecord::Migration[7.1]
  def change
    add_reference :goals, :user, null: false, foreign_key: true
  end
end
