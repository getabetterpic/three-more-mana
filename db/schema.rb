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

ActiveRecord::Schema.define(version: 2018_12_01_155222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "deck_cards", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.bigint "card_id", null: false
    t.integer "card_count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_deck_cards_on_card_id"
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "mtg_cards", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "layout"
    t.boolean "hires_image"
    t.jsonb "image_uris"
    t.string "mana_cost"
    t.decimal "cmc"
    t.string "type_line"
    t.string "oracle_text"
    t.string "power"
    t.string "toughness"
    t.jsonb "colors"
    t.jsonb "color_identity"
    t.jsonb "legalities"
    t.string "set_code", null: false
    t.string "rarity"
    t.jsonb "card_faces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["set_code"], name: "index_mtg_cards_on_set_code"
    t.index ["uuid"], name: "index_mtg_cards_on_uuid", unique: true
  end

  create_table "mtg_sets", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "set_type"
    t.integer "card_count"
    t.string "parent_set_code"
    t.date "released_at"
    t.string "block_code"
    t.string "block"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_mtg_sets_on_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.citext "email"
    t.string "name"
    t.string "password_digest"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
