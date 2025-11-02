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

ActiveRecord::Schema[8.1].define(version: 2024_11_13_134622) do
  create_table "activities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "memo"
    t.string "type", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["created_at"], name: "index_activities_on_created_at"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.string "message", null: false
    t.integer "reacted_user_id"
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_reactions_on_activity_id"
    t.index ["reacted_user_id"], name: "index_reactions_on_reacted_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "activities", "users"
  add_foreign_key "reactions", "activities"
  add_foreign_key "reactions", "users", column: "reacted_user_id"
end
