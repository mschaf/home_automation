class AddIndentifierToSensorsAndActors < ActiveRecord::Migration[5.2]
  def change
    add_column :sensors, :identifier, :string
    add_column :actors, :identifier, :string
    add_column :things, :identifier, :string
  end
end
