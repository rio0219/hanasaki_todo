class AddRequiredCountToFlowers < ActiveRecord::Migration[7.1]
  def change
    add_column :flowers, :required_count, :integer
  end
end
