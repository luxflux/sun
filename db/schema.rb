# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151028201657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["name"], name: "index_locations_on_name", using: :btree

  create_table "metrics", force: :cascade do |t|
    t.float    "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "input_id"
  end

  create_table "ports", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "type"
    t.integer  "number"
    t.integer  "signal_type"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ports", ["location_id"], name: "index_ports_on_location_id", using: :btree

  create_table "rules", force: :cascade do |t|
    t.integer  "input_id"
    t.integer  "rule"
    t.integer  "threshold"
    t.integer  "output_id"
    t.integer  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rules", ["input_id"], name: "index_rules_on_input_id", using: :btree
  add_index "rules", ["output_id"], name: "index_rules_on_output_id", using: :btree

  add_foreign_key "ports", "locations"
  add_foreign_key "rules", "ports", column: "input_id"
  add_foreign_key "rules", "ports", column: "output_id"
end
