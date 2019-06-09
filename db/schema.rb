# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_08_125829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actor_plugs", force: :cascade do |t|
    t.boolean "state"
  end

  create_table "actors", force: :cascade do |t|
    t.string "actable_type"
    t.bigint "actable_id"
    t.string "name"
    t.integer "thing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actable_type", "actable_id"], name: "index_actors_on_actable_type_and_actable_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "action"
    t.string "parameters"
    t.integer "actor_id"
    t.datetime "execute_at"
    t.boolean "execute_on_monday"
    t.boolean "execute_on_tuesday"
    t.boolean "execute_on_wednesday"
    t.boolean "execute_on_thursday"
    t.boolean "execute_on_friday"
    t.boolean "execute_on_saturday"
    t.boolean "execute_on_sunday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "things", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "address"
    t.datetime "last_seen"
  end

end
