# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_13_221420) do

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "universal_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["universal_key"], name: "index_accounts_on_universal_key"
  end

  create_table "applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "universal_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["universal_key"], name: "index_applications_on_universal_key"
  end

  create_table "configuration_values", force: :cascade do |t|
    t.string "path", null: false
    t.text "value", null: false
    t.integer "application_id"
    t.integer "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.index "\"application\", \"account\"", name: "index_configuration_values_on_application_and_account"
    t.index ["account_id"], name: "index_configuration_values_on_account_id"
    t.index ["application_id"], name: "index_configuration_values_on_application_id"
  end

  create_table "events_audits", force: :cascade do |t|
    t.string "entity_type", null: false
    t.json "payload", null: false
    t.datetime "created_at", null: false
    t.integer "entity_id", null: false
    t.index ["entity_type", "entity_id"], name: "index_events_audits_on_entity_type_and_entity_id"
  end

  add_foreign_key "configuration_values", "accounts"
  add_foreign_key "configuration_values", "applications"
  add_foreign_key "configuration_values", "configuration_values", column: "parent_id", on_update: :cascade, on_delete: :cascade
end
