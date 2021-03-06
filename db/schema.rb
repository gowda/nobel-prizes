# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_30_161308) do

  create_table "awards", force: :cascade do |t|
    t.string "motivation"
    t.string "portion", default: "1"
    t.integer "sort_order", default: 1
    t.integer "prize_id", null: false
    t.integer "laureate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["laureate_id"], name: "index_awards_on_laureate_id"
    t.index ["prize_id"], name: "index_awards_on_prize_id"
  end

  create_table "categories", primary_key: "cid", id: { type: :string, limit: 64 }, force: :cascade do |t|
    t.string "name"
    t.string "short"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "prize_count", default: 0
  end

  create_table "laureates", force: :cascade do |t|
    t.string "remote_id"
    t.string "name"
    t.string "link"
    t.boolean "org"
    t.boolean "person"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "prize_count"
    t.string "thumbnail_url"
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "native_name"
    t.string "acronym"
    t.integer "birth_place_id"
    t.integer "death_place_id"
    t.integer "founded_place_id"
    t.string "birth_date_string"
    t.datetime "birth_date"
    t.string "death_date_string"
    t.datetime "death_date"
    t.string "founded_date_string"
    t.datetime "founded_date"
    t.index ["remote_id"], name: "index_laureates_on_remote_id", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "city_then"
    t.string "country"
    t.string "country_then"
    t.string "continent"
    t.string "wiki_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prizes", force: :cascade do |t|
    t.string "year"
    t.integer "amount"
    t.string "link"
    t.string "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "laureate_count", default: 0
    t.index ["year", "category_id"], name: "index_prizes_on_year_and_category_id", unique: true
  end

  add_foreign_key "awards", "laureates"
  add_foreign_key "awards", "prizes"
  add_foreign_key "laureates", "locations", column: "birth_place_id"
  add_foreign_key "laureates", "locations", column: "death_place_id"
  add_foreign_key "laureates", "locations", column: "founded_place_id"
  add_foreign_key "prizes", "categories", primary_key: "cid"
end
