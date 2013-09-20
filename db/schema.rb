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

ActiveRecord::Schema.define(version: 20130918143422) do

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
    t.integer  "num_iid",      limit: 8,   null: false
    t.integer  "picture_id",   limit: 8,   null: false
    t.string   "picture_path", limit: 300, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "picture_upload_logs", ["nick"], name: "index_picture_upload_logs_on_nick", using: :btree
  add_index "picture_upload_logs", ["num_iid"], name: "index_picture_upload_logs_on_num_iid", using: :btree
  add_index "picture_upload_logs", ["picture_id"], name: "index_picture_upload_logs_on_picture_id", using: :btree

end
