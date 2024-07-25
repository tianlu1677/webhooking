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

ActiveRecord::Schema[7.0].define(version: 2024_07_25_160905) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "custom_action_logs", force: :cascade do |t|
    t.integer "webhook_id"
    t.integer "from_custom_action_id"
    t.integer "next_custom_action_id"
    t.integer "request_id"
    t.jsonb "original_params"
    t.jsonb "custom_params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_actions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "custom_action"
    t.bigint "webhook_id", null: false
    t.string "category"
    t.jsonb "input_dict"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["webhook_id"], name: "index_custom_actions_on_webhook_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "uuid"
    t.string "url"
    t.string "req_method"
    t.string "ip"
    t.string "hostname"
    t.string "user_agent"
    t.string "referer"
    t.jsonb "headers"
    t.integer "status_code"
    t.integer "user_id"
    t.string "token_uuid"
    t.integer "webhook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "content_length", default: 0
    t.jsonb "query_params"
    t.jsonb "form_params"
    t.string "content_type"
    t.string "media_type"
    t.text "raw_content"
    t.string "path"
    t.index ["webhook_id"], name: "index_requests_on_webhook_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "webhooks", force: :cascade do |t|
    t.string "uuid"
    t.string "receive_email"
    t.datetime "expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "resp_code", default: 200
    t.string "resp_body", default: ""
    t.string "resp_content_type", default: "text/plain"
    t.boolean "cors_enabled", default: true
    t.text "script_content"
    t.string "short"
    t.index ["short"], name: "index_webhooks_on_short", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "custom_actions", "webhooks"
end
