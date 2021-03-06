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

ActiveRecord::Schema.define(version: 20150706033743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "datasource_id"
    t.datetime "activity_timestamp"
    t.string   "action"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "connectors", force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled",             default: true
    t.integer  "user_count",          default: 0
    t.datetime "last_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "jobs_pending"
    t.integer  "jobs_duration_min"
    t.integer  "jobs_duration_max"
    t.integer  "jobs_duration_avg"
    t.integer  "hourly_synced_count"
    t.integer  "daily_synced_count"
  end

  create_table "datasources", force: :cascade do |t|
    t.boolean  "enabled",            default: false
    t.boolean  "authorized",         default: false
    t.date     "start_date"
    t.string   "company_2_tf_token"
    t.datetime "status_changed_at"
    t.datetime "last_sync_at"
    t.datetime "next_sync_at"
    t.string   "status_message"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "errors", force: :cascade do |t|
    t.string   "error_type"
    t.datetime "error_timestamp"
    t.string   "message"
    t.string   "company_2_tf_token"
    t.json     "bad_orders"
    t.string   "friendly_message"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
