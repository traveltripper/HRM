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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161024101859) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "announcements", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "message",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "employee_id", limit: 4
  end

  create_table "conference_rooms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "available"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "conferencerooms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "available"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name",                   limit: 255
    t.string   "last_name",                    limit: 255
    t.integer  "manager_id",                   limit: 4
    t.integer  "role_id",                      limit: 4
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "email",                        limit: 255,   default: "", null: false
    t.string   "encrypted_password",           limit: 255,   default: "", null: false
    t.string   "reset_password_token",         limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",           limit: 255
    t.string   "last_sign_in_ip",              limit: 255
    t.string   "phone",                        limit: 255
    t.string   "middle_name",                  limit: 255
    t.integer  "ttid",                         limit: 4
    t.string   "personal_email",               limit: 255
    t.string   "contact_no",                   limit: 255
    t.datetime "actual_dob"
    t.datetime "certificate_dob"
    t.string   "emergency_name",               limit: 255
    t.string   "emergency_contact_no",         limit: 255
    t.datetime "doj"
    t.integer  "prev_years_of_exp",            limit: 4
    t.string   "pg",                           limit: 255
    t.string   "graduation",                   limit: 255
    t.text     "address",                      limit: 65535
    t.string   "source_of_hire",               limit: 255
    t.string   "pancard_no",                   limit: 255
    t.string   "passport_no",                  limit: 255
    t.integer  "department_id",                limit: 4
    t.string   "status",                       limit: 255
    t.datetime "lwd"
    t.datetime "date_of_resignation"
    t.string   "nationality",                  limit: 255
    t.string   "blood_group",                  limit: 255
    t.string   "marital_status",               limit: 255
    t.string   "graduation_institution",       limit: 255
    t.string   "graduation_university",        limit: 255
    t.string   "pg_university",                limit: 255
    t.string   "pg_institution",               limit: 255
    t.string   "previous_employer",            limit: 255
    t.string   "pf_no",                        limit: 255
    t.string   "aadhar_no",                    limit: 255
    t.text     "current_address",              limit: 65535
    t.string   "father_or_spouse",             limit: 255
    t.string   "health_insurance_card_no",     limit: 255
    t.string   "profile_picture_file_name",    limit: 255
    t.string   "profile_picture_content_type", limit: 255
    t.integer  "profile_picture_file_size",    limit: 4
    t.datetime "profile_picture_updated_at"
    t.datetime "date_of_joining"
    t.integer  "days_of_leave",                limit: 4,     default: 0
    t.integer  "leave_used",                   limit: 4,     default: 0
    t.string   "skype_id",                     limit: 255
    t.string   "designation",                  limit: 255
    t.text     "about_me",                     limit: 65535
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.text     "reason",               limit: 65535
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
  end

  create_table "leaves", force: :cascade do |t|
    t.integer  "employee_id",   limit: 4
    t.datetime "fromdate"
    t.datetime "todate"
    t.text     "reason",        limit: 65535
    t.boolean  "status"
    t.integer  "no_of_days",    limit: 4
    t.integer  "leavetype_id",  limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "leave_balance", limit: 4
    t.text     "reject_reason", limit: 65535
  end

  create_table "leavetypes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payrolls", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.string   "attachment",  limit: 255
    t.datetime "pay_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
