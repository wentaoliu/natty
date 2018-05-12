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

ActiveRecord::Schema.define(version: 2018_05_06_002531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.integer "owner"
    t.string "action"
    t.integer "subject_id"
    t.string "subject_type"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "instrument_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "record"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_bookings_on_instrument_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "topic_id"
    t.integer "user_id"
    t.integer "reply_to"
    t.string "content"
    t.boolean "proved", default: false
    t.boolean "hidden", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_comments_on_topic_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "forums", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "hidden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instruments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "serial_number"
    t.string "description"
    t.integer "maintainer"
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "item_name"
    t.float "price"
    t.integer "quantity"
    t.string "unit_size"
    t.string "url"
    t.string "technical_details"
    t.datetime "expiration_date"
    t.string "cas_number"
    t.string "serial_number"
    t.string "bought_from"
    t.string "location"
    t.string "sub_location"
    t.string "location_details"
    t.string "type"
    t.string "vendor_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "content"
    t.integer "like", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pictures", id: :serial, force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "email_public"
    t.integer "position", default: 0
    t.integer "grade"
    t.integer "rank", default: 0
    t.string "resume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "resources", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.integer "parent"
    t.integer "ancestors", default: [], array: true
    t.boolean "is_folder"
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_resources_on_user_id"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "category"
    t.string "place"
    t.string "content"
    t.boolean "bulletin", default: false
    t.boolean "private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "forum_id"
    t.string "title"
    t.string "content"
    t.string "tags", default: [], array: true
    t.integer "comments_count", default: 0
    t.integer "hits", default: 0
    t.boolean "hidden", default: false
    t.boolean "allow_comments", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forum_id"], name: "index_topics_on_forum_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "authentication_token"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "name", default: ""
    t.string "locale"
    t.integer "state", default: 0
    t.boolean "admin", default: false
    t.integer "permission", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "wiki_id"
    t.string "title"
    t.string "category"
    t.string "content"
    t.string "comment"
    t.boolean "current", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_versions_on_user_id"
    t.index ["wiki_id"], name: "index_versions_on_wiki_id"
  end

  create_table "wikis", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "category"
    t.string "content"
    t.string "comment"
    t.boolean "locked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wikis_on_user_id"
  end

end
