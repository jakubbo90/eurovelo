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

ActiveRecord::Schema.define(version: 20180514110321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_mailers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "street_number"
    t.string "city"
    t.string "postcode"
    t.string "phone"
    t.string "cellphone"
    t.string "email"
    t.string "link"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "alerts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "region_id"
    t.string "name"
    t.string "description"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "time_from"
    t.datetime "time_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author"
    t.index ["region_id"], name: "index_alerts_on_region_id"
    t.index ["user_id"], name: "index_alerts_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "attachmentable_type"
    t.bigint "attachmentable_id"
    t.string "source_file_name"
    t.string "source_content_type"
    t.integer "source_file_size"
    t.datetime "source_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachmentable_type", "attachmentable_id"], name: "index_attachments_on_attachmentable_type_and_attachmentable_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level"
    t.string "type"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "category_descriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "short_desc"
    t.text "long_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["user_id"], name: "index_category_descriptions_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.string "link"
    t.string "provider"
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_identities_on_place_id"
  end

  create_table "password_expirations", force: :cascade do |t|
    t.datetime "expiration_date"
    t.integer "period_in_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string "picturable_type"
    t.bigint "picturable_id"
    t.string "source_file_name"
    t.string "source_content_type"
    t.integer "source_file_size"
    t.datetime "source_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "main"
    t.index ["picturable_type", "picturable_id"], name: "index_pictures_on_picturable_type_and_picturable_id"
  end

  create_table "place_categories", force: :cascade do |t|
    t.bigint "place_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_place_categories_on_category_id"
    t.index ["place_id"], name: "index_place_categories_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "short_desc"
    t.text "long_desc"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.bigint "region_id"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author"
    t.index ["category_id"], name: "index_places_on_category_id"
    t.index ["region_id"], name: "index_places_on_region_id"
    t.index ["user_id"], name: "index_places_on_user_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "trail_places", force: :cascade do |t|
    t.bigint "trail_id"
    t.bigint "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_trail_places_on_place_id"
    t.index ["trail_id"], name: "index_trail_places_on_trail_id"
  end

  create_table "trails", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "short_desc"
    t.string "long_desc"
    t.decimal "distance", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "region_id"
    t.string "author"
    t.index ["category_id"], name: "index_trails_on_category_id"
    t.index ["region_id"], name: "index_trails_on_region_id"
    t.index ["user_id"], name: "index_trails_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "authorizer_id"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.string "company"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "password_created_at"
    t.string "role"
    t.bigint "region_id"
    t.integer "parent_id"
    t.boolean "accept_terms"
    t.index ["authorizer_id"], name: "index_users_on_authorizer_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["region_id"], name: "index_users_on_region_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.string "videoable_type"
    t.bigint "videoable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["videoable_type", "videoable_id"], name: "index_videos_on_videoable_type_and_videoable_id"
  end

  add_foreign_key "alerts", "regions"
  add_foreign_key "alerts", "users"
  add_foreign_key "identities", "places"
  add_foreign_key "place_categories", "categories"
  add_foreign_key "place_categories", "places"
  add_foreign_key "regions", "countries"
  add_foreign_key "trail_places", "places"
  add_foreign_key "trail_places", "trails"
  add_foreign_key "trails", "categories"
  add_foreign_key "trails", "regions"
  add_foreign_key "trails", "users"
  add_foreign_key "users", "regions"
end
