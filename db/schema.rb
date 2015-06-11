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

ActiveRecord::Schema.define(version: 20150611175135) do

  create_table "font_sets", force: true do |t|
    t.text     "sass"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "main_headline"
    t.string   "secondary_headline"
    t.string   "body"
    t.string   "byline"
    t.string   "pullquote"
    t.string   "blockquote"
    t.string   "big_number"
    t.string   "big_number_label"
  end

  add_index "font_sets", ["project_id"], name: "index_font_sets_on_project_id"

  create_table "projects", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "feature_image_url"
    t.string   "background_url"
    t.string   "lede_image_url"
    t.string   "three_up_first_url"
    t.string   "three_up_last_url"
    t.string   "primary_color"
    t.string   "secondary_color"
    t.string   "logo_url"
    t.string   "collection_url"
  end

end
