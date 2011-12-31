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

ActiveRecord::Schema.define(:version => 20111228154833) do

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
    t.string   "profile_selfphoto"
    t.string   "profile_tel"
    t.string   "profile_email"
    t.string   "profile_department"
    t.string   "profile_hobby"
    t.string   "profile_askme"
    t.string   "profile_language"
    t.string   "profile_nationality"
    t.string   "profile_hometown"
    t.string   "profile_focus"
    t.string   "profile_workplace"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
