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

ActiveRecord::Schema.define(version: 2021_03_17_160018) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friends", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "friend_user_id", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["friend_user_id"], name: "index_friends_on_friend_user_id"
    t.index ["user_id", "friend_user_id"], name: "index_friends_on_user_id_and_friend_user_id", unique: true
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "wish_id", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["wish_id"], name: "index_images_on_wish_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "account_id", default: "None", null: false
    t.string "picture_url"
    t.index ["account_id"], name: "index_users_on_account_id", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  create_table "wishes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.integer "star", null: false
    t.integer "status", default: 0, null: false, comment: "default: wish"
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_wishes_on_category_id"
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "friends", "Users", column: "friend_user_id"
  add_foreign_key "friends", "Users", column: "user_id"
  add_foreign_key "images", "wishes"
  add_foreign_key "wishes", "categories"
  add_foreign_key "wishes", "users"
end
