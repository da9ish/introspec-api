# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_12_23_144000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buckets", force: :cascade do |t|
    t.string "name", null: false
    t.string "identifier", null: false
    t.bigint "environment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["environment_id"], name: "index_buckets_on_environment_id"
    t.index ["identifier"], name: "index_buckets_on_identifier", unique: true
    t.index ["name"], name: "index_buckets_on_name"
  end

  create_table "columns", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.string "data_type", null: false
    t.boolean "default_value"
    t.boolean "is_array", default: false
    t.boolean "is_indexed", default: false
    t.boolean "is_primary", default: false
    t.boolean "is_unique", default: false
    t.boolean "is_nullable", default: false
    t.bigint "table_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier", "table_id"], name: "index_columns_on_identifier_and_table_id", unique: true
    t.index ["is_array"], name: "index_columns_on_is_array"
    t.index ["is_indexed"], name: "index_columns_on_is_indexed"
    t.index ["is_nullable"], name: "index_columns_on_is_nullable"
    t.index ["is_primary"], name: "index_columns_on_is_primary"
    t.index ["is_unique"], name: "index_columns_on_is_unique"
    t.index ["name"], name: "index_columns_on_name"
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "database_configurations", force: :cascade do |t|
    t.string "name", null: false
    t.string "identifier", null: false
    t.string "host"
    t.string "port", null: false
    t.string "allocated_storage", null: false
    t.string "db_instance_class", null: false
    t.string "db_instance_identifier", null: false
    t.string "engine", null: false
    t.string "db_name", null: false
    t.string "username", null: false
    t.string "encrypted_password", null: false
    t.string "status", null: false
    t.jsonb "raw_response"
    t.bigint "database_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["database_id"], name: "index_database_configurations_on_database_id"
    t.index ["identifier"], name: "index_database_configurations_on_identifier", unique: true
    t.index ["name"], name: "index_database_configurations_on_name"
  end

  create_table "databases", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.bigint "environment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["environment_id"], name: "index_databases_on_environment_id"
    t.index ["identifier"], name: "index_databases_on_identifier", unique: true
    t.index ["name"], name: "index_databases_on_name"
  end

  create_table "early_accesses", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_early_accesses_on_email", unique: true
  end

  create_table "environments", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.bigint "workspace_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier", "workspace_id"], name: "index_environments_on_identifier_and_workspace_id", unique: true
    t.index ["name"], name: "index_environments_on_name"
    t.index ["workspace_id"], name: "index_environments_on_workspace_id"
  end

  create_table "files", force: :cascade do |t|
    t.string "name", null: false
    t.string "identifier", null: false
    t.bigint "size", null: false
    t.string "file_type", null: false
    t.string "relative_path", null: false
    t.bigint "folder_id"
    t.bigint "bucket_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bucket_id"], name: "index_files_on_bucket_id"
    t.index ["folder_id"], name: "index_files_on_folder_id"
    t.index ["identifier", "bucket_id"], name: "index_files_on_identifier_and_bucket_id", unique: true
    t.index ["identifier", "folder_id"], name: "index_files_on_identifier_and_folder_id", unique: true
    t.index ["name"], name: "index_files_on_name"
  end

  create_table "folders", force: :cascade do |t|
    t.string "name", null: false
    t.string "identifier", null: false
    t.string "relative_path", null: false
    t.bigint "bucket_id"
    t.bigint "folder_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bucket_id"], name: "index_folders_on_bucket_id"
    t.index ["folder_id"], name: "index_folders_on_folder_id"
    t.index ["identifier", "bucket_id"], name: "index_folders_on_identifier_and_bucket_id", unique: true
    t.index ["name"], name: "index_folders_on_name"
  end

  create_table "storage_configurations", force: :cascade do |t|
    t.string "name", null: false
    t.string "identifier", null: false
    t.string "location"
    t.jsonb "raw_response"
    t.bigint "bucket_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bucket_id"], name: "index_storage_configurations_on_bucket_id"
    t.index ["identifier"], name: "index_storage_configurations_on_identifier", unique: true
    t.index ["name"], name: "index_storage_configurations_on_name"
  end

  create_table "tables", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.bigint "database_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["database_id"], name: "index_tables_on_database_id"
    t.index ["identifier", "database_id"], name: "index_tables_on_identifier_and_database_id", unique: true
    t.index ["name"], name: "index_tables_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "jti"
    t.string "string"
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "role", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "profile_pic", default: ""
    t.bigint "workspace_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
    t.index ["workspace_id"], name: "index_users_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.string "logo"
    t.string "public_api_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_workspaces_on_identifier", unique: true
    t.index ["name"], name: "index_workspaces_on_name", unique: true
    t.index ["public_api_key"], name: "index_workspaces_on_public_api_key", unique: true
  end

end
