class FixUserIdNullInGoals < ActiveRecord::Migration[7.1]
  def up
    add_column :goals, :user_id, :integer, null: true

    # モデルを使うのでreset_column_information必須
    Goal.reset_column_information
    Goal.update_all(user_id: 1)

    change_column_null :goals, :user_id, false
    add_foreign_key :goals, :users
  end

  def down
    remove_foreign_key :goals, :users
    remove_column :goals, :user_id
  end
end

