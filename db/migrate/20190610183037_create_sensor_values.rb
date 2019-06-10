class CreateSensorValues < ActiveRecord::Migration[5.2]
  def change
    create_table :sensor_values do |t|
      t.integer :sensor_id
      t.float :value

      t.datetime :created_at, null: false
    end
  end
end
