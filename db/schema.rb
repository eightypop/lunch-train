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

ActiveRecord::Schema.define(version: 20141105200434) do

  create_table "lines", force: true do |t|
    t.string   "name"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "rider_id"
    t.integer  "station_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["rider_id", "station_id"], name: "index_ratings_on_rider_id_and_station_id", unique: true, using: :btree

  create_table "riders", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "riders", ["email"], name: "index_riders_on_email", unique: true, using: :btree
  add_index "riders", ["reset_password_token"], name: "index_riders_on_reset_password_token", unique: true, using: :btree

  create_table "riders_trains", id: false, force: true do |t|
    t.integer "train_id", null: false
    t.integer "rider_id", null: false
  end

  create_table "stations", force: true do |t|
    t.string   "name"
    t.decimal  "lat",        precision: 15, scale: 10
    t.decimal  "lon",        precision: 15, scale: 10
    t.boolean  "open",                                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trains", force: true do |t|
    t.datetime "depart_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "station_id"
  end

end
