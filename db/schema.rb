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

ActiveRecord::Schema.define(version: 20150407205355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",                                     null: false
    t.string   "photo_url"
    t.text     "self_summary"
    t.text     "good_at"
    t.text     "message_if"
    t.integer  "height"
    t.integer  "weight"
    t.string   "body_type"
    t.string   "weight_class"
    t.string   "style"
    t.boolean  "looking_for_wrestler",         default: true
    t.boolean  "looking_for_boxer",            default: true
    t.boolean  "looking_for_mma_figher",       default: true
    t.boolean  "looking_for_other_styles",     default: true
    t.boolean  "looking_for_women",            default: true
    t.boolean  "looking_for_men",              default: true
    t.boolean  "looking_for_opponent",         default: true
    t.boolean  "looking_for_sparring_partner", default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "session_token",   null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "profiles", "users"
end