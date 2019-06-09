class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
      t.string :type
      t.string :name
      t.string :address
      t.datetime :last_seen
    end
  end
end
