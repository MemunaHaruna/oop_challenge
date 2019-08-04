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

ActiveRecord::Schema.define(version: 2019_08_03_174616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_classifications", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "customer_id"
    t.integer "age"
    t.string "gender"
    t.bigint "region_id"
    t.bigint "job_classification_id"
    t.string "date_joined"
    t.integer "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_classification_id"], name: "index_users_on_job_classification_id"
    t.index ["region_id"], name: "index_users_on_region_id"
  end

  add_foreign_key "users", "job_classifications"
  add_foreign_key "users", "regions"
end
