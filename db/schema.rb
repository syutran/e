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

ActiveRecord::Schema.define(:version => 20111009123704) do

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.integer  "super"
    t.text     "description"
    t.boolean  "act"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "storage_id"
    t.integer  "user_id"
    t.integer  "rule_id"
    t.integer  "category_id"
    t.string   "typies"
    t.text     "title"
    t.text     "itema"
    t.text     "itemb"
    t.text     "itemc"
    t.text     "itemd"
    t.text     "iteme"
    t.text     "itemf"
    t.text     "itemg"
    t.text     "itemh"
    t.text     "itemi"
    t.text     "itemj"
    t.string   "rkey"
    t.string   "akey"
    t.integer  "needtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "record_id"
  end

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.text     "msg"
    t.string   "state"
    t.boolean  "readmsg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msgs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "from_user"
    t.string   "msg"
    t.boolean  "act"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", :force => true do |t|
    t.string   "title"
    t.string   "state"
    t.integer  "need_time"
    t.integer  "source_user_id"
    t.integer  "use_time"
    t.integer  "reward"
    t.datetime "start_time"
    t.datetime "finish_time"
    t.float    "score"
    t.text     "records"
    t.datetime "timestamps"
    t.integer  "user_id"
    t.datetime "limit_time"
    t.integer  "success"
    t.integer  "success_time"
    t.integer  "faileds"
    t.integer  "faileds_time"
    t.integer  "rule_id"
  end

  create_table "rules", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "category_id"
    t.integer  "limit_time"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "limits"
    t.boolean  "reward"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_category_id"
    t.string   "typies"
    t.float    "fee"
  end

  create_table "rules_user_categories", :id => false, :force => true do |t|
    t.integer  "rule_id"
    t.integer  "user_category_id"
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

  create_table "storages", :force => true do |t|
    t.string   "master"
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "typies"
    t.text     "title"
    t.text     "itema"
    t.text     "itemb"
    t.text     "itemc"
    t.text     "itemd"
    t.text     "iteme"
    t.text     "itemf"
    t.text     "itemg"
    t.text     "itemh"
    t.text     "itemi"
    t.text     "itemj"
    t.string   "key"
    t.integer  "needtime"
    t.integer  "speed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_categories", :force => true do |t|
    t.string   "title"
    t.string   "extent"
    t.text     "users"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "sex"
    t.date     "birthday"
    t.string   "city"
    t.string   "address"
    t.string   "telephone"
    t.boolean  "act"
    t.integer  "category_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_category_id"
    t.string   "face_file_name"
    t.string   "face_content_type"
    t.integer  "face_file_size"
    t.boolean  "admin"
    t.float    "money"
  end

end
