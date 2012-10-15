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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121015041936) do

  create_table "carts", :force => true do |t|
    t.integer  "user_id",    :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",          :limit => 8
    t.integer  "product_id",       :limit => 8
    t.integer  "product_quantity", :limit => 8
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.float    "price"
  end

  create_table "product_orders", :force => true do |t|
    t.integer  "product_id", :limit => 8
    t.integer  "quantity",   :limit => 8
    t.integer  "cart_id",    :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "products", :force => true do |t|
    t.integer  "inventory",   :limit => 8
    t.float    "price"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "authenticated"
    t.boolean  "admin"
  end

  create_table "wish_lists", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "priv"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "wishes", :force => true do |t|
    t.integer  "product_id"
    t.integer  "wish_list_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
