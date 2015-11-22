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

ActiveRecord::Schema.define(version: 20151122002102) do

  create_table "alert_subscription", id: false, force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "alert_type_id", null: false
  end

  add_index "alert_subscription", ["alert_type_id", "user_id"], name: "index_alert_subscription_on_alert_type_id_and_user_id"

  create_table "alert_types", force: :cascade do |t|
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "alerts", ["user_id"], name: "index_alerts_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "group_member_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "phone_number"
  end

end
