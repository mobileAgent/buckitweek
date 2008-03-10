# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "age_ranges", :force => true do |t|
    t.integer "low",  :null => false
    t.integer "high", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "year",                               :null => false
    t.string   "location",           :default => "", :null => false
    t.integer  "registration_cost",  :default => 0,  :null => false
    t.integer  "registration_count", :default => 0,  :null => false
    t.integer  "max_seats",          :default => 0,  :null => false
    t.integer  "lock_version",       :default => 0,  :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "registrations", :force => true do |t|
    t.string   "address1",                  :default => "", :null => false
    t.string   "address2"
    t.string   "city",                      :default => "", :null => false
    t.string   "state",        :limit => 2
    t.string   "phone",                     :default => "", :null => false
    t.string   "first_name",                :default => "", :null => false
    t.string   "last_name",                 :default => "", :null => false
    t.string   "middle_name"
    t.integer  "age_range_id",              :default => 0,  :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "lock_version",              :default => 0,  :null => false
    t.integer  "event_id"
    t.integer  "amount_paid",               :default => 0,  :null => false
    t.integer  "amount_owed",               :default => 0,  :null => false
    t.integer  "user_id",                                   :null => false
    t.string   "gender",       :limit => 1, :default => "", :null => false
    t.string   "zip_code"
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :limit => 128, :default => "",    :null => false
    t.string   "hashed_password",                :default => "",    :null => false
    t.string   "salt",                           :default => "",    :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "last_visit",                                        :null => false
    t.boolean  "admin",                          :default => false, :null => false
    t.integer  "lock_version",                   :default => 0,     :null => false
    t.boolean  "activated",                      :default => false, :null => false
  end

end
