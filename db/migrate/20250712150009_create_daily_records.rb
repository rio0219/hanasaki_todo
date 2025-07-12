class CreateDailyRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_records do |t|
      t.references :goal, null: false, foreign_key: true
      t.date :date
      t.integer :count

      t.timestamps
    end
  end
end
