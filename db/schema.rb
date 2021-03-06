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

ActiveRecord::Schema.define(version: 20160628161832) do

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true

  create_table "checkouts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "telephone"
    t.string   "address"
    t.date     "delivery_date"
    t.string   "delivery_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "price"
    t.integer  "quantity",    default: 1
    t.integer  "sku_id"
    t.integer  "order_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "checkout_id"
  end

  add_index "line_items", ["checkout_id"], name: "index_line_items_on_checkout_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["sku_id"], name: "index_line_items_on_sku_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "price"
    t.string   "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.integer  "category_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "quantity"
    t.string   "unit"
    t.integer  "premium_price"
    t.integer  "normal_price"
  end

  add_index "packages", ["category_id", "unit", "quantity"], name: "index_packages_on_category_id_and_unit_and_quantity", unique: true

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "premium",            default: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "products", ["category_id", "name"], name: "index_products_on_category_id_and_name", unique: true

  create_table "skus", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.integer  "package_id"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "skus", ["category_id"], name: "index_skus_on_category_id"
  add_index "skus", ["package_id"], name: "index_skus_on_package_id"
  add_index "skus", ["product_id"], name: "index_skus_on_product_id"

end
