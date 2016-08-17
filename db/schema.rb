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

ActiveRecord::Schema.define(version: 20160816182447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content",       null: false
    t.integer  "user_id"
    t.integer  "discussion_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "discussions", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.integer  "user_id"
    t.integer  "podcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_discussions_on_podcast_id", using: :btree
    t.index ["user_id"], name: "index_discussions_on_user_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "podcast_tags", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "podcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_podcast_tags_on_podcast_id", using: :btree
    t.index ["tag_id"], name: "index_podcast_tags_on_tag_id", using: :btree
  end

  create_table "podcast_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "podcast_id"
    t.boolean  "favorite",   default: false
    t.boolean  "in_queue",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["podcast_id"], name: "index_podcast_users_on_podcast_id", using: :btree
    t.index ["user_id"], name: "index_podcast_users_on_user_id", using: :btree
  end

  create_table "podcasts", force: :cascade do |t|
    t.string   "genre",      null: false
    t.string   "title",      null: false
    t.string   "artist",     null: false
    t.string   "image30"
    t.string   "image60"
    t.string   "image100"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "username",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "online",                 default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
