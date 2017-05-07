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

ActiveRecord::Schema.define(version: 20170507081329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_action_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "path"
    t.string   "action"
    t.text     "changes_log"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["resource_id", "resource_type"], name: "index_active_admin_action_logs_on_resource_id_and_resource_type", using: :btree
    t.index ["user_id"], name: "index_active_admin_action_logs_on_user_id", using: :btree
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "announcements", force: :cascade do |t|
    t.string   "title",          null: false
    t.text     "body",           null: false
    t.date     "published_date", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "article_comments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "comment"
    t.integer  "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_comments_on_article_id", using: :btree
    t.index ["user_id"], name: "index_article_comments_on_user_id", using: :btree
  end

  create_table "article_tags", force: :cascade do |t|
    t.integer  "tag_id",     null: false
    t.integer  "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_tags_on_article_id", using: :btree
    t.index ["tag_id"], name: "index_article_tags_on_tag_id", using: :btree
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "shipped_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "comments_count", default: 0, null: false
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "group_assignments", force: :cascade do |t|
    t.integer  "group_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_assignments_on_group_id", using: :btree
    t.index ["user_id"], name: "index_group_assignments_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "email",       null: false
    t.text     "description"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "help_texts", force: :cascade do |t|
    t.string   "category"
    t.string   "help_type"
    t.string   "target"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category", "help_type"], name: "index_help_texts_on_category_and_help_type", using: :btree
  end

  create_table "inquiries", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "body",       null: false
    t.string   "referer"
    t.string   "user_agent"
    t.string   "session_id"
    t.text     "admin_memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inquiries_on_user_id", using: :btree
  end

  create_table "monthly_report_comments", force: :cascade do |t|
    t.integer  "user_id",           null: false
    t.text     "comment"
    t.integer  "monthly_report_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "monthly_report_tags", force: :cascade do |t|
    t.integer  "monthly_report_id", null: false
    t.integer  "tag_id",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "monthly_reports", force: :cascade do |t|
    t.integer  "user_id",                      null: false
    t.date     "target_month",                 null: false
    t.datetime "shipped_at"
    t.text     "project_summary"
    t.text     "business_content"
    t.text     "looking_back"
    t.text     "next_month_goals"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "comments_count",   default: 0, null: false
    t.index ["target_month"], name: "index_monthly_reports_on_target_month", using: :btree
  end

  create_table "monthly_working_processes", force: :cascade do |t|
    t.integer  "monthly_report_id"
    t.boolean  "process_definition",     default: false, null: false
    t.boolean  "process_design",         default: false, null: false
    t.boolean  "process_implementation", default: false, null: false
    t.boolean  "process_test",           default: false, null: false
    t.boolean  "process_operation",      default: false, null: false
    t.boolean  "process_analysis",       default: false, null: false
    t.boolean  "process_training",       default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "process_structure",      default: false, null: false
    t.boolean  "process_trouble",        default: false, null: false
    t.index ["monthly_report_id"], name: "index_monthly_working_processes_on_monthly_report_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "status",     default: 0, null: false
    t.string   "name",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "index_tags_on_name", using: :btree
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id",                       null: false
    t.text     "self_introduction"
    t.integer  "blood_type",        default: 0, null: false
    t.date     "birthday"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id", unique: true, using: :btree
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "employee_code"
    t.string   "encrypted_email",                     null: false
    t.date     "entry_date"
    t.boolean  "beginner_flg"
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "gender",                 default: 0,  null: false
    t.index ["encrypted_email"], name: "index_users_on_encrypted_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "active_admin_action_logs", "users"
  add_foreign_key "articles", "users"
  add_foreign_key "group_assignments", "groups"
  add_foreign_key "group_assignments", "users"
  add_foreign_key "monthly_working_processes", "monthly_reports"
  add_foreign_key "user_profiles", "users"
end
