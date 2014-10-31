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

ActiveRecord::Schema.define(version: 20141031075509) do

  create_table "admin_owners", force: true do |t|
    t.string   "email"
    t.integer  "phone"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_owners", ["email"], name: "index_admin_owners_on_email", unique: true
  add_index "admin_owners", ["remember_token"], name: "index_admin_owners_on_remember_token"

  create_table "carousels", force: true do |t|
    t.integer  "store_id"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carousels", ["store_id"], name: "index_carousels_on_store_id"

  create_table "cars", force: true do |t|
    t.integer  "user_id"
    t.integer  "skucate_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cars", ["user_id"], name: "index_cars_on_user_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
  end

  add_index "categories", ["store_id"], name: "index_categories_on_store_id"

  create_table "collecting_relationships", force: true do |t|
    t.integer  "store_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collecting_relationships", ["store_id", "user_id"], name: "index_collecting_relationships_on_store_id_and_user_id", unique: true
  add_index "collecting_relationships", ["user_id"], name: "index_collecting_relationships_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_id"
  end

  add_index "comments", ["product_id"], name: "index_comments_on_product_id"
  add_index "comments", ["reply_id"], name: "index_comments_on_reply_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "details", force: true do |t|
    t.integer  "product_id"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  add_index "details", ["product_id"], name: "index_details_on_product_id"

  create_table "following_relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "following_relationships", ["followed_id"], name: "index_following_relationships_on_followed_id"
  add_index "following_relationships", ["follower_id", "followed_id"], name: "index_following_relationships_on_follower_id_and_followed_id", unique: true
  add_index "following_relationships", ["follower_id"], name: "index_following_relationships_on_follower_id"

  create_table "imglists", force: true do |t|
    t.integer  "product_id"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  add_index "imglists", ["product_id"], name: "index_imglists_on_product_id"

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "store_id"
    t.integer  "product_id"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.boolean  "status",     default: false
    t.integer  "reply_id"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "nosign_cars", force: true do |t|
    t.integer  "skucate_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nosign_id"
  end

  add_index "nosign_cars", ["nosign_id"], name: "index_nosign_cars_on_nosign_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "main_img"
    t.integer  "buy_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_id"
    t.integer  "quantity"
    t.boolean  "status",                               default: true
    t.decimal  "price",       precision: 10, scale: 2
  end

  add_index "products", ["category_id", "status"], name: "index_products_on_category_id_and_status"
  add_index "products", ["name"], name: "index_products_on_name"

  create_table "properties", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["product_id"], name: "index_properties_on_product_id"

  create_table "replies", force: true do |t|
    t.integer  "owner_id"
    t.integer  "comment_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["comment_id"], name: "index_replies_on_comment_id"

  create_table "skucates", force: true do |t|
    t.string   "name1"
    t.string   "value1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.string   "name2"
    t.string   "value2"
  end

  add_index "skucates", ["name1", "value1", "name2", "value2"], name: "index_skucates_on_name1_and_value1_and_name2_and_value2"
  add_index "skucates", ["product_id"], name: "index_skucates_on_product_id"

  create_table "skulists", force: true do |t|
    t.float    "price"
    t.string   "icon_url"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skucate_id"
    t.float    "oldprice"
  end

  add_index "skulists", ["skucate_id"], name: "index_skulists_on_skucate_id"

  create_table "stores", force: true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background"
    t.string   "slogan"
  end

  add_index "stores", ["owner_id"], name: "index_stores_on_owner_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "province"
    t.string   "city"
    t.string   "address"
    t.integer  "phone",           limit: 5
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
