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

ActiveRecord::Schema.define(version: 20160201171615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name"
  end

  create_table "agencies_contracts", id: false, force: :cascade do |t|
    t.integer "contract_id", null: false
    t.integer "agency_id",   null: false
  end

  add_index "agencies_contracts", ["agency_id", "contract_id"], name: "index_agencies_contracts_on_agency_id_and_contract_id", unique: true, using: :btree

  create_table "contracts", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.string   "description"
    t.datetime "pubdate"
    t.decimal  "dollar_amt",  precision: 16, scale: 2
    t.string   "creator"
  end

end
