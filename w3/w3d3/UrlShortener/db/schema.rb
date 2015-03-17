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

ActiveRecord::Schema.define(version: 20140820235609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shortened_urls", force: true do |t|
    t.string   "short_url",    null: false
    t.string   "long_url",     null: false
    t.integer  "submitter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shortened_urls", ["short_url"], name: "index_shortened_urls_on_short_url", unique: true, using: :btree
  add_index "shortened_urls", ["submitter_id"], name: "index_shortened_urls_on_submitter_id", using: :btree

  create_table "tag_topics", force: true do |t|
    t.string   "tag_topic",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_topics", ["tag_topic"], name: "index_tag_topics_on_tag_topic", unique: true, using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "url_id",       null: false
    t.integer  "tag_topic_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_topic_id"], name: "index_taggings_on_tag_topic_id", using: :btree
  add_index "taggings", ["url_id", "tag_topic_id"], name: "index_taggings_on_url_id_and_tag_topic_id", unique: true, using: :btree
  add_index "taggings", ["url_id"], name: "index_taggings_on_url_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "visits", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visitor_id", null: false
    t.integer  "url_id",     null: false
  end

  add_index "visits", ["url_id"], name: "index_visits_on_url_id", using: :btree
  add_index "visits", ["visitor_id"], name: "index_visits_on_visitor_id", using: :btree

end
