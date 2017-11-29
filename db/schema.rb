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

ActiveRecord::Schema.define(version: 20161221101152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.text     "message"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "employee_id"
    t.string   "slug"
    t.boolean  "active",      default: true
  end

  add_index "announcements", ["slug"], name: "index_announcements_on_slug", unique: true, using: :btree

  create_table "conference_rooms", force: :cascade do |t|
    t.string   "name"
    t.boolean  "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cpps", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "designation"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "manager_id"
    t.integer  "role_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "email",                         default: "",    null: false
    t.string   "encrypted_password",            default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                 default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone"
    t.string   "middle_name"
    t.string   "ttid"
    t.string   "personal_email"
    t.string   "contact_no"
    t.datetime "actual_dob"
    t.datetime "certificate_dob"
    t.string   "emergency_name"
    t.string   "emergency_contact_no"
    t.datetime "doj"
    t.integer  "prev_years_of_exp"
    t.string   "pg"
    t.string   "graduation"
    t.text     "address"
    t.string   "source_of_hire"
    t.string   "pancard_no"
    t.string   "passport_no"
    t.integer  "department_id"
    t.string   "status"
    t.datetime "lwd"
    t.datetime "date_of_resignation"
    t.string   "nationality"
    t.string   "blood_group"
    t.string   "marital_status"
    t.string   "graduation_institution"
    t.string   "graduation_university"
    t.string   "pg_university"
    t.string   "pg_institution"
    t.string   "previous_employer"
    t.string   "pf_no"
    t.string   "aadhar_no"
    t.text     "current_address"
    t.string   "father_or_spouse"
    t.string   "health_insurance_card_no"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.datetime "date_of_joining"
    t.integer  "days_of_leave"
    t.integer  "leave_used",                    default: 0
    t.string   "skype_id"
    t.string   "designation"
    t.text     "about_me"
    t.string   "no_of_health_ins_cards_issued"
    t.boolean  "password_changed"
    t.boolean  "welcome_email_sent",            default: false
    t.integer  "work_from_home_used",           default: 0
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "end_date"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "reason"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "employee_id"
    t.boolean  "publish",              default: true
    t.string   "slug"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "healthinsurances", force: :cascade do |t|
    t.string   "name"
    t.string   "card_number"
    t.string   "relation"
    t.datetime "issued_date"
    t.datetime "policy_start_date"
    t.datetime "policy_end_date"
    t.integer  "employee_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "leaves", force: :cascade do |t|
    t.integer  "employee_id"
    t.datetime "fromdate"
    t.datetime "todate"
    t.text     "reason"
    t.boolean  "status"
    t.integer  "no_of_days"
    t.integer  "leavetype_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "leave_balance"
    t.text     "reject_reason"
    t.boolean  "leave_cancel",   default: false
    t.boolean  "work_from_home", default: false
  end

  create_table "leavetypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nominations", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "payrolls", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "attachment"
    t.datetime "pay_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pollanswers", force: :cascade do |t|
    t.integer  "pollquestion_id"
    t.string   "option"
    t.boolean  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pollquestions", force: :cascade do |t|
    t.text     "question"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "polls", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "pollanswer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "pollquestion_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
