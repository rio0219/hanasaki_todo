class AddUserIdToGoals < ActiveRecord::Migration[7.1]
  def up
    add_reference :goals, :user, null: true, foreign_key: true

    Goal.reset_column_information
    Goal.update_all(user_id: 1)

    change_column_null :goals, :user_id, false
  end

  def down
    remove_reference :goals, :user, foreign_key: true
  end
end
