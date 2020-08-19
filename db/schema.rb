# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_19_130819) do

  create_table "alternate_titles", force: :cascade do |t|
    t.string "name"
    t.integer "program_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_alternate_titles_on_program_id"
  end

  create_table "director_aliases", force: :cascade do |t|
    t.string "name"
    t.integer "director_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["director_id"], name: "index_director_aliases_on_director_id"
  end

  create_table "directors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "disc_packages", force: :cascade do |t|
    t.integer "disc_id", null: false
    t.integer "package_id", null: false
    t.integer "sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["disc_id"], name: "index_disc_packages_on_disc_id"
    t.index ["package_id"], name: "index_disc_packages_on_package_id"
  end

  create_table "disc_programs", force: :cascade do |t|
    t.integer "disc_id", null: false
    t.integer "program_id", null: false
    t.integer "sequence"
    t.string "program_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["disc_id"], name: "index_disc_programs_on_disc_id"
    t.index ["program_id"], name: "index_disc_programs_on_program_id"
  end

  create_table "discs", force: :cascade do |t|
    t.string "format"
    t.integer "location_id", null: false
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_discs_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.string "sort_name"
    t.string "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "version"
    t.integer "minutes"
  end

  create_table "programs_directors", id: false, force: :cascade do |t|
    t.integer "program_id", null: false
    t.integer "director_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["director_id"], name: "index_programs_directors_on_director_id"
    t.index ["program_id"], name: "index_programs_directors_on_program_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "series_programs", force: :cascade do |t|
    t.integer "series_id", null: false
    t.integer "program_id", null: false
    t.integer "sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_series_programs_on_program_id"
    t.index ["series_id"], name: "index_series_programs_on_series_id"
  end

  add_foreign_key "alternate_titles", "programs"
  add_foreign_key "director_aliases", "directors"
  add_foreign_key "disc_packages", "discs"
  add_foreign_key "disc_packages", "packages"
  add_foreign_key "disc_programs", "discs"
  add_foreign_key "disc_programs", "programs"
  add_foreign_key "discs", "locations"
  add_foreign_key "programs_directors", "directors"
  add_foreign_key "programs_directors", "programs"
  add_foreign_key "series_programs", "programs"
  add_foreign_key "series_programs", "series"
end
