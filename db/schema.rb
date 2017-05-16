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

ActiveRecord::Schema.define(version: 20170511102141) do

  create_table "comment_stars", force: :cascade do |t|
    t.integer  "comment_id",    null: false
    t.integer  "created_by_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["comment_id"], name: "index_comment_stars_on_comment_id"
    t.index ["created_by_id"], name: "index_comment_stars_on_created_by_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "stack_id",                   null: false
    t.text     "body",                      null: false
    t.integer  "created_by_id",             null: false
    t.integer  "star_count",    default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["created_by_id"], name: "index_comments_on_created_by_id"
    t.index ["stack_id"], name: "index_comments_on_stack_id"
  end

  create_table "stack_stars", force: :cascade do |t|
    t.integer  "stack_id",       null: false
    t.integer  "created_by_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["created_by_id"], name: "index_stack_stars_on_created_by_id"
    t.index ["stack_id"], name: "index_stack_stars_on_stack_id"
  end

  create_table "stacks", force: :cascade do |t|
    t.integer  "list_id",                    null: false
    t.string   "title",                      null: false
    t.text     "note",          default: "", null: false
    t.integer  "status",        default: 0,  null: false
    t.integer  "star_count",    default: 0,  null: false
    t.integer  "created_by_id",              null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["created_by_id"], name: "index_stacks_on_created_by_id"
    t.index ["list_id"], name: "index_stacks_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name",                          null: false
    t.integer  "order",                         null: false
    t.integer  "status",        default: 0,     null: false
    t.integer  "created_by_id",                 null: false
    t.boolean  "is_system",     default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["created_by_id"], name: "index_lists_on_created_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",            default: "slack", null: false
    t.string   "uid",                 default: "",      null: false
    t.string   "encrypted_password",  default: "",      null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
