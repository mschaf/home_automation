class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :action
      t.string :parameters

      t.integer :actor_id
      t.datetime  :execute_at

      t.boolean :execute_on_monday
      t.boolean :execute_on_tuesday
      t.boolean :execute_on_wednesday
      t.boolean :execute_on_thursday
      t.boolean :execute_on_friday
      t.boolean :execute_on_saturday
      t.boolean :execute_on_sunday

      t.timestamps
    end
  end
end
