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

ActiveRecord::Schema.define(:version => 20120601233225) do

  create_table "data_providers", :force => true do |t|
    t.string   "name"
    t.string   "root_url"
    t.integer  "sanctioning_body_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "data_providers", ["sanctioning_body_id"], :name => "index_data_providers_on_sanctioning_body_id"

  create_table "meets", :force => true do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.string   "course"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "races", :force => true do |t|
    t.string   "stroke"
    t.integer  "distance"
    t.float    "time"
    t.float    "points"
    t.integer  "place"
    t.string   "standard_achieved"
    t.integer  "swimmer_id"
    t.integer  "sanctioning_body_id"
    t.integer  "meet_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "races", ["meet_id"], :name => "index_races_on_meet_id"
  add_index "races", ["sanctioning_body_id"], :name => "index_races_on_sanctioning_body_id"
  add_index "races", ["swimmer_id"], :name => "index_races_on_swimmer_id"

  create_table "sanctioning_bodies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "swimmer_id_keys", :force => true do |t|
    t.integer  "swimmer_id"
    t.integer  "data_provider_id"
    t.string   "key"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "swimmers", :force => true do |t|
    t.date     "dob"
    t.string   "first"
    t.string   "last"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
