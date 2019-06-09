class CreateActors < ActiveRecord::Migration[5.2]
  def change
    create_table :actors do |t|
      t.actable
      t.string :name
      t.integer :thing_id

      t.timestamps
    end
  end
end
