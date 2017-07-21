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

ActiveRecord::Schema.define(version: 20170711212824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "acts_as_having_has_as", force: :cascade do |t|
    t.string   "haser_type"
    t.integer  "haser_id"
    t.string   "hased_type"
    t.integer  "hased_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "acts_as_relating_to_relationship_invitations", force: :cascade do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.integer  "status",         default: 0
    t.integer  "role_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "acts_as_relating_to_relationships", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "in_relation_to_id"
    t.string   "in_relation_to_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "acts_as_relating_to_roles", force: :cascade do |t|
    t.string   "name"
    t.string   "display_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "reciprocal"
  end

  create_table "app_collaborators_access_grants", force: :cascade do |t|
    t.integer  "app_client_id"
    t.string   "code"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "resource_owner_id"
    t.integer  "access_token_id"
  end

  create_table "app_collaborators_access_tokens", force: :cascade do |t|
    t.integer  "application_id"
    t.string   "application_type"
    t.integer  "resource_owner_id"
    t.string   "token"
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.uuid     "uuid"
    t.uuid     "application_uuid"
  end

  create_table "app_collaborators_api_service_transactions", force: :cascade do |t|
    t.integer  "api_service_id"
    t.integer  "app_client_id"
    t.string   "result_status"
    t.string   "result"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "app_collaborators_app_clients", force: :cascade do |t|
    t.string   "name"
    t.string   "secret"
    t.text     "redirect_uri"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "display_name"
    t.string   "api_key"
    t.uuid     "uuid"
  end

  create_table "app_collaborators_app_providers", force: :cascade do |t|
    t.string   "name"
    t.string   "uri"
    t.string   "base_path"
    t.string   "uuid"
    t.string   "secret"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "app_client_type"
    t.integer  "app_client_id"
  end

  create_table "app_collaborators_scopes", force: :cascade do |t|
    t.string   "code"
    t.string   "display_text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "bars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "haz_as", force: :cascade do |t|
    t.string   "hazer_type"
    t.integer  "hazer_id"
    t.string   "hazed_type"
    t.integer  "hazed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
