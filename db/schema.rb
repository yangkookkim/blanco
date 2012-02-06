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

ActiveRecord::Schema.define(:version => 20120206044618) do

  create_table "employee_groups", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_tags", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon"
    t.string   "portrait"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.boolean  "is_feedbackgroup"
    t.string   "due"
    t.string   "share_with"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "group_id"
    t.text     "message"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "profiles", :force => true do |t|
    t.string   "selfphoto"
    t.string   "imagephoto"
    t.string   "tel"
    t.string   "email"
    t.string   "department"
    t.string   "hobby"
    t.string   "askme"
    t.string   "language"
    t.string   "nationality"
    t.string   "hometown"
    t.string   "workplace"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "focus"
    t.integer  "employee_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
