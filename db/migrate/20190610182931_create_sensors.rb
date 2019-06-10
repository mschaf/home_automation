class CreateSensors < ActiveRecord::Migration[5.2]
  def change
    create_table :sensors do |t|
      t.integer :thing_id
      t.string :name
      t.string :unit

      t.timestamps
    end
  end
end
