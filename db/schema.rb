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

ActiveRecord::Schema.define(version: 2018_05_16_152531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", id: :serial, force: :cascade do |t|
    t.string "action_type", null: false
    t.string "action_option"
    t.string "target_type"
    t.integer "target_id"
    t.string "user_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id", "action_type"], name: "index_actions_on_target_type_and_target_id_and_action_type"
    t.index ["user_type", "user_id", "action_type"], name: "index_actions_on_user_type_and_user_id_and_action_type"
  end

  create_table "activities", force: :cascade do |t|
    t.integer "user_id"
    t.string "poster"
    t.string "title"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "circles", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "friend_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "tag"
    t.integer "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labels_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "label_id", null: false
    t.index ["label_id", "user_id"], name: "index_labels_users_on_label_id_and_user_id"
    t.index ["user_id", "label_id"], name: "index_labels_users_on_user_id_and_label_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0
    t.integer "stars_count", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone", limit: 11
    t.string "open_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "viper", default: false
    t.boolean "corporater", default: false
    t.boolean "job", default: false
    t.string "profession"
    t.integer "vipercount", default: 2
    t.string "badge"
    t.string "company"
    t.boolean "authentication", default: false
    t.string "sex"
    t.date "birthday"
    t.string "province"
    t.string "city"
    t.string "school"
    t.string "industry"
    t.text "summary"
    t.string "business_licence"
    t.integer "star_posts_count", default: 0
    t.integer "followers_count", default: 0
    t.integer "following_count", default: 0
    t.string "photo"
    t.index ["open_id"], name: "index_users_on_open_id"
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["token"], name: "index_users_on_token"
  end

end
