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

ActiveRecord::Schema.define(version: 2021_05_12_174055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "payment_cancellations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "payment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_payment_cancellations_on_payment_id", unique: true
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subscription_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at", "subscription_id"], name: "index_payments_on_created_at_and_subscription_id", unique: true
  end

  create_table "repositories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "name", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name"], name: "index_repositories_on_user_id_and_name", unique: true
  end

  create_table "ssh_keys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "name", null: false
    t.text "key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key"], name: "index_ssh_keys_on_key", unique: true
    t.index ["user_id"], name: "index_ssh_keys_on_user_id", unique: true
  end

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.decimal "price", null: false
    t.datetime "deactivated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at", "user_id"], name: "index_subscriptions_on_created_at_and_user_id", unique: true
    t.index ["user_id"], name: "index_subscriptions_on_user_id", unique: true, where: "(deactivated_at IS NULL)"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "email", null: false
    t.text "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "repositories", "users"
  add_foreign_key "ssh_keys", "users"

  create_view "subscription_states", sql_definition: <<-SQL
      SELECT s.id AS subscription_id,
      ((s.deactivated_at IS NULL) AND (EXISTS ( SELECT
             FROM payments p
            WHERE ((p.subscription_id = s.id) AND (p.created_at >= (CURRENT_TIMESTAMP - 'P30D'::interval)) AND (NOT (EXISTS ( SELECT
                     FROM payment_cancellations pc
                    WHERE (pc.payment_id = p.id)))))))) AS active
     FROM subscriptions s;
  SQL
end
