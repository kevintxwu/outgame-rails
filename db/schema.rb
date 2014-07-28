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

ActiveRecord::Schema.define(version: 20140727063528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts_events", id: false, force: true do |t|
    t.integer "account_id"
    t.integer "event_id"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "date"
    t.string   "type"
    t.string   "bracket"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "event_type"
    t.string   "bracket_type"
    t.text     "teams"
    t.text     "scores"
  end

  create_table "events_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  add_index "events_users", ["event_id"], name: "index_events_users_on_event_id", using: :btree
  add_index "events_users", ["user_id"], name: "index_events_users_on_user_id", using: :btree

  create_table "games", force: true do |t|
    t.boolean  "p1_win",      default: false
    t.boolean  "p2_win",      default: false
    t.integer  "round_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "contestants"
  end

  add_index "games", ["round_id"], name: "index_games_on_round_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", force: true do |t|
    t.integer  "event_id"
    t.boolean  "active"
    t.integer  "round_number"
    t.text     "byes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["event_id"], name: "index_rounds_on_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "type"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
