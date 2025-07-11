class CreateTaskRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :task_records do |t|
      t.references :task, null: false, foreign_key: true
      t.date :date
      t.boolean :done

      t.timestamps
    end
  end
end
