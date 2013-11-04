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

ActiveRecord::Schema.define(version: 20131025105205) do

  create_table "feedbacks", force: true do |t|
    t.string   "nick",             limit: 60, null: false
    t.string   "feedback_name",    limit: 60
    t.text     "feedback_message",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["nick"], name: "index_feedbacks_on_nick", using: :btree

  create_table "logos", force: true do |t|
    t.string   "nick",             limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
  end

  add_index "logos", ["nick"], name: "index_logos_on_nick", using: :btree

  create_table "picture_upload_logs", force: true do |t|
    t.string   "nick",         limit: 60,  null: false
    t.integer  "num_iid",      limit: 8
    t.integer  "picture_id",   limit: 8,   null: false
    t.string   "picture_path", limit: 300, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",         limit: 60,  null: false
    t.integer  "sid",          limit: 8
    t.string   "title",        limit: 60
  end

  add_index "picture_upload_logs", ["nick"], name: "index_picture_upload_logs_on_nick", using: :btree
  add_index "picture_upload_logs", ["num_iid"], name: "index_picture_upload_logs_on_num_iid", using: :btree
  add_index "picture_upload_logs", ["picture_id"], name: "index_picture_upload_logs_on_picture_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "shop_cards", force: true do |t|
    t.integer  "sid",         limit: 8,   null: false
    t.string   "nick",        limit: 60,  null: false
    t.string   "title",       limit: 60,  null: false
    t.string   "email",       limit: 60
    t.string   "phone",       limit: 30
    t.string   "qq",          limit: 30
    t.string   "wangwang",    limit: 30
    t.string   "weixin",      limit: 30
    t.string   "sina_weibo",  limit: 30
    t.string   "shop_url",    limit: 200
    t.string   "address",     limit: 60
    t.text     "qr_code_img"
    t.text     "shop_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shop_cards", ["nick"], name: "index_shop_cards_on_nick", unique: true, using: :btree
  add_index "shop_cards", ["sid"], name: "index_shop_cards_on_sid", unique: true, using: :btree

  create_table "shortened_urls", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type", limit: 20
    t.string   "url",        limit: 20000,             null: false
    t.string   "unique_key", limit: 10,                null: false
    t.integer  "use_count",                default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shortened_urls", ["owner_id", "owner_type"], name: "index_shortened_urls_on_owner_id_and_owner_type", using: :btree
  add_index "shortened_urls", ["unique_key"], name: "index_shortened_urls_on_unique_key", unique: true, using: :btree
  add_index "shortened_urls", ["url"], name: "index_shortened_urls_on_url", length: {"url"=>255}, using: :btree

  create_table "visit_logs", force: true do |t|
    t.string   "nick",       limit: 60, null: false
    t.string   "controller", limit: 60, null: false
    t.string   "action",     limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visit_logs", ["action"], name: "index_visit_logs_on_action", using: :btree
  add_index "visit_logs", ["controller"], name: "index_visit_logs_on_controller", using: :btree
  add_index "visit_logs", ["nick"], name: "index_visit_logs_on_nick", using: :btree

end
