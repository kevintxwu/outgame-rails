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

ActiveRecord::Schema.define(version: 20140612022510) do

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
  end

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_events", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

end
