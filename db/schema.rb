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

ActiveRecord::Schema.define(version: 2021_11_18_091310) do

  create_table "guests", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "guest_id", null: false
    t.string "code", null: false
    t.string "client", null: false
    t.string "guest_phone_numbers", null: false
    t.string "status", null: false
    t.string "currency", null: false
    t.string "raw_data", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "nights", default: 0
    t.integer "guests", default: 0
    t.integer "adults", default: 0
    t.integer "children", default: 0
    t.integer "infants", default: 0
    t.string "guest_description"
    t.decimal "payout_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "security_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_amount", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client"], name: "index_reservations_on_client"
    t.index ["code", "client"], name: "index_reservations_on_code_and_client", unique: true
    t.index ["code"], name: "index_reservations_on_code"
    t.index ["end_date"], name: "index_reservations_on_end_date"
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["start_date"], name: "index_reservations_on_start_date"
  end

end
