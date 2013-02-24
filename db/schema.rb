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

ActiveRecord::Schema.define(:version => 20130224112551) do

  create_table "game_user_relations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "game_user_relations", ["game_id"], :name => "index_game_user_relations_on_game_id"
  add_index "game_user_relations", ["user_id"], :name => "index_game_user_relations_on_user_id"

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "map_image"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "games", ["user_id"], :name => "index_games_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "location_info"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "game_id"
  end

  add_index "locations", ["game_id"], :name => "index_locations_on_game_id"

  create_table "point_coordinates", :force => true do |t|
    t.string   "MAC"
    t.integer  "signal_str"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "point_coordinates", ["location_id"], :name => "index_point_coordinates_on_location_id"

  create_table "user_location_relations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_location_relations", ["location_id"], :name => "index_user_location_relations_on_location_id"
  add_index "user_location_relations", ["user_id"], :name => "index_user_location_relations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
