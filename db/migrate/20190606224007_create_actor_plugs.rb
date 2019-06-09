class CreateActorPlugs < ActiveRecord::Migration[5.2]
  def change
    create_table :actor_plugs do |t|
      t.boolean :state
    end
  end
end
