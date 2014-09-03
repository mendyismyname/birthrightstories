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

ActiveRecord::Schema.define(version: 20140903222923) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "hashtags", force: true do |t|
    t.string   "name"
    t.datetime "refreshed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "hashtags", ["slug"], name: "index_hashtags_on_slug", unique: true, using: :btree

  create_table "instagram_images", force: true do |t|
    t.string   "tags"
    t.string   "users_in_photo"
    t.string   "filter"
    t.string   "comments"
    t.string   "caption"
    t.string   "likes"
    t.string   "link"
    t.integer  "instagram_user_id"
    t.string   "images"
    t.integer  "instagram_media_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instagram_media", force: true do |t|
    t.text     "users_in_photo"
    t.string   "filter"
    t.text     "tags"
    t.text     "comments"
    t.text     "caption"
    t.text     "likes"
    t.datetime "created_time"
    t.text     "images"
    t.string   "instagram_id"
    t.string   "location"
    t.text     "videos"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "instagram_user_id"
    t.string   "media_type"
  end

  create_table "instagram_media_hashtags", force: true do |t|
    t.integer  "instagram_media_id"
    t.integer  "hashtag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instagram_media_hashtags", ["hashtag_id"], name: "index_instagram_media_hashtags_on_hashtag_id", using: :btree

  create_table "instagram_users", force: true do |t|
    t.integer  "instagram_id"
    t.string   "username"
    t.string   "full_name"
    t.text     "bio"
    t.string   "profile_picture"
    t.string   "website"
    t.integer  "media_count"
    t.integer  "follows_count"
    t.integer  "followed_by_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
