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

ActiveRecord::Schema.define(version: 20151101053303) do

  create_table "cashflows", force: :cascade do |t|
    t.float    "flow"
    t.float    "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagrams", force: :cascade do |t|
    t.float    "investment"
    t.float    "MARR"
    t.float    "capacity"
    t.float    "pur"
    t.float    "puc"
    t.float    "om"
    t.float    "salv"
    t.float    "horiz"
    t.float    "deprec_time"
    t.boolean  "deprec_type"
    t.float    "DB_per"
    t.float    "loan_amt"
    t.float    "loan_time"
    t.float    "loan_interest_rate"
    t.boolean  "loan_type"
    t.float    "tax_rate"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
