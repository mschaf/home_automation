class AddCurrentValueToSensors < ActiveRecord::Migration[5.2]
  def change
    add_column :sensors, :current_value, :float
  end
end
