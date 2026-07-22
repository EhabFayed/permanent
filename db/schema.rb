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

ActiveRecord::Schema[8.0].define(version: 2026_07_22_004318) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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

  create_table "blog_photos", force: :cascade do |t|
    t.bigint "blog_id", null: false
    t.string "alt_ar"
    t.string "alt_en"
    t.boolean "is_landing", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_blog_photos_on_blog_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "photo_id"
    t.string "title_ar"
    t.string "title_en"
    t.string "description_ar"
    t.string "description_en"
    t.string "image_alt_text_ar"
    t.string "image_alt_text_en"
    t.string "meta_title_ar"
    t.string "meta_title_en"
    t.string "slug"
    t.string "slug_ar"
    t.text "meta_description_ar"
    t.text "meta_description_en"
    t.boolean "is_published", default: false
    t.boolean "is_highlighted", default: false
    t.boolean "is_deleted", default: false
    t.integer "category"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_blogs_on_slug", unique: true
    t.index ["slug_ar"], name: "index_blogs_on_slug_ar", unique: true
  end

  create_table "content_photos", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.string "alt_ar"
    t.string "alt_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_photos_on_content_id"
  end

  create_table "contents", force: :cascade do |t|
    t.text "content_ar"
    t.text "content_en"
    t.string "parentable_type"
    t.bigint "parentable_id"
    t.integer "user_id"
    t.boolean "is_deleted", default: false
    t.boolean "is_published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parentable_type", "parentable_id"], name: "index_contents_on_parentable"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question_ar"
    t.string "question_en"
    t.text "answer_ar"
    t.text "answer_en"
    t.string "parentable_type"
    t.bigint "parentable_id"
    t.boolean "is_deleted", default: false
    t.boolean "is_published", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parentable_type", "parentable_id"], name: "index_faqs_on_parentable"
  end

  create_table "product_photos", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "alt_ar"
    t.string "alt_en"
    t.boolean "is_landing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_photos_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "category"
    t.string "description_ar"
    t.string "description_en"
    t.boolean "is_published", default: false
    t.string "size_ar"
    t.string "size_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "title_en"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blog_photos", "blogs"
  add_foreign_key "content_photos", "contents"
  add_foreign_key "product_photos", "products"
end
