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

ActiveRecord::Schema.define(version: 20150918171936) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acts_as_relating_to_relationships", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "in_relation_to_id"
    t.string   "in_relation_to_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
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
  end

  create_table "app_collaborators_app_clients", force: :cascade do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "secret"
    t.text     "redirect_uri"
    t.string   "scopes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
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

  create_table "bars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "graph_resource_resource_bases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "graph_id"
  end

  create_table "instrument_builder_haz_as", force: :cascade do |t|
    t.string   "hazer_type"
    t.integer  "hazer_id"
    t.string   "hazd_type"
    t.integer  "hazd_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instrument_builder_instrument_assets", force: :cascade do |t|
    t.string   "asset_type"
    t.string   "container"
    t.string   "size"
    t.string   "asset"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instrument_builder_instrument_element_class_sources", force: :cascade do |t|
    t.string   "class_name"
    t.string   "filter_type"
    t.string   "filter_on_field"
    t.text     "filter_on_values", default: [],              array: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "instrument_builder_instrument_element_templates", force: :cascade do |t|
    t.string   "name"
    t.integer  "version"
    t.string   "mappings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instrument_builder_instrument_elements", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.string   "template_name"
    t.string   "source_type"
    t.integer  "source_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "template_version"
    t.string   "template_mappings"
    t.string   "question_text"
    t.string   "spec"
    t.integer  "file_format_version"
  end

  create_table "instrument_builder_instrument_panels", force: :cascade do |t|
    t.string   "name"
    t.string   "template_name"
    t.string   "title"
    t.text     "instrument_elements", default: [],              array: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "instrument_builder_manual_list_sources", force: :cascade do |t|
    t.string   "list"
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

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
