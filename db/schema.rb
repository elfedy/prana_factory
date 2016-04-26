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

ActiveRecord::Schema.define(version: 20160426124443) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

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

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "description"
    t.string   "image_url"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "premium",     default: false
  end

  create_table "skus", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.integer  "package_id"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
