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

ActiveRecord::Schema.define(:version => 20111225183700) do

  create_table "bons", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cashboxes", :force => true do |t|
    t.string   "ip"
    t.integer  "port"
    t.string   "name"
    t.integer  "printer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "printers", :force => true do |t|
    t.string   "name"
    t.string   "cups_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "special_guest_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "special_guests", :force => true do |t|
    t.string   "uid"
    t.string   "forename"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "ticket_sales", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.boolean  "custom",            :default => false
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "available_from"
    t.datetime "available_until"
    t.integer  "position"
    t.boolean  "upgrade"
    t.boolean  "presale"
    t.integer  "upgrade_ticket_id"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "workshift_id"
    t.boolean  "canceled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "special_guest_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",              :limit => 40
    t.string   "name",               :limit => 100, :default => ""
    t.string   "email",              :limit => 100
    t.string   "encrypted_password",                :default => "",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                             :default => false
    t.boolean  "tainted"
    t.integer  "sign_in_count",                     :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "workshift_tickets", :force => true do |t|
    t.integer  "workshift_id"
    t.integer  "ticket_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workshifts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "money"
    t.boolean  "active",        :default => false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "cleared_at"
    t.boolean  "balanced"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cashbox_id"
    t.integer  "cleared_by_id"
    t.string   "state"
  end

end
