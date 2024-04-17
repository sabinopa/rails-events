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

ActiveRecord::Schema[7.1].define(version: 2024_04_17_125329) do
  create_table "companies", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "description"
    t.integer "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_companies_on_supplier_id"
  end

  create_table "companies_payment_methods", id: false, force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.index ["company_id", "payment_method_id"], name: "idx_on_company_id_payment_method_id_3c91e7d35a"
    t.index ["payment_method_id", "company_id"], name: "idx_on_payment_method_id_company_id_83dd18334b"
  end

  create_table "event_pricings", force: :cascade do |t|
    t.integer "event_type_id", null: false
    t.decimal "base_price", precision: 10, scale: 2
    t.integer "base_attendees"
    t.decimal "additional_guest_price", precision: 10, scale: 2
    t.decimal "extra_hour_price", precision: 10, scale: 2
    t.boolean "weekend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type_id"], name: "index_event_pricings_on_event_type_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "min_attendees"
    t.integer "max_attendees"
    t.integer "duration"
    t.text "menu_description"
    t.boolean "alcohol_available"
    t.boolean "decoration_available"
    t.boolean "parking_service_available"
    t.integer "location_type"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_event_types_on_company_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_suppliers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_suppliers_on_reset_password_token", unique: true
  end

  add_foreign_key "companies", "suppliers"
  add_foreign_key "event_pricings", "event_types"
  add_foreign_key "event_types", "companies"
end
