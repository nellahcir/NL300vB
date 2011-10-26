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

ActiveRecord::Schema.define(:version => 20110111013634) do

  create_table "checkins", :force => true do |t|
    t.integer  "musher_id"
    t.integer  "checkpoint_id"
    t.integer  "dogs"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkouts", :force => true do |t|
    t.integer  "musher_id"
    t.integer  "checkpoint_id"
    t.integer  "dogs"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkpoints", :force => true do |t|
    t.string   "name"
    t.integer  "sequence"
    t.integer  "milepost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mushers", :force => true do |t|
    t.string   "name"
    t.integer  "bibnum"
    t.integer  "dogs"
    t.integer  "year"
    t.integer  "stpos"
    t.integer  "status_id"
    t.datetime "restartdiff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "standings", :force => true do |t|
    t.string   "a"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.boolean  "proceed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timedcps", :force => true do |t|
    t.integer  "checkpoint_id"
    t.integer  "startInterval"
    t.integer  "minMakeup"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "updates", :force => true do |t|
    t.integer  "musher_id"
    t.integer  "checkpoint_id"
    t.datetime "timein"
    t.integer  "dogsin"
    t.datetime "timeout"
    t.integer  "dogsout"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "access_level"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
