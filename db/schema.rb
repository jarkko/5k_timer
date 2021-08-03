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

ActiveRecord::Schema.define(version: 20150526133146) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: :cascade do |t|
    t.integer  "runner_id"
    t.integer  "result",     limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "timer_id",             default: 1, null: false
    t.string   "bib_number"
  end

  create_table "runners", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bib_number"
    t.integer  "category_id"
    t.index ["bib_number"], name: "index_runners_on_bib_number", unique: true
  end

  create_table "timers", force: :cascade do |t|
    t.integer  "start_time", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
