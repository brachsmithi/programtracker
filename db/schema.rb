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

ActiveRecord::Schema.define(version: 2020_09_15_193523) do

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
    t.string "name"
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

  create_table "program_version_clusters", force: :cascade do |t|
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
    t.integer "program_version_cluster_id"
    t.index ["program_version_cluster_id"], name: "index_programs_on_program_version_cluster_id"
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
  add_foreign_key "programs", "program_version_clusters"
  add_foreign_key "programs_directors", "directors"
  add_foreign_key "programs_directors", "programs"
  add_foreign_key "series_programs", "programs"
  add_foreign_key "series_programs", "series"

  create_view "discs_searches", sql_definition: <<-SQL
      SELECT 
    d.*,
    CASE
      WHEN d.name IS NOT NULL AND trim(d.name) != ''
        THEN
          CASE
            WHEN d.name LIKE 'A %'
              THEN
                lower(substr(d.name, 3))
            WHEN d.name LIKE 'An %'
              THEN
                lower(substr(d.name, 4))
            WHEN d.name LIKE 'The %'
              THEN
                lower(substr(d.name, 5))
            ELSE
              lower(d.name)
          END
      WHEN dps.program_sort IS NOT NULL AND dps.program_sort != '' AND dps.program_type = 'FEATURE'
        THEN dps.program_sort
      WHEN dpkg1.package_sort IS NOT NULL AND dpkg1.package_sort != ''
        THEN dpkg1.package_sort
      WHEN dps.series_sort IS NOT NULL AND dps.series_sort != ''
        THEN dps.series_sort
      WHEN dps.program_sort IS NOT NULL AND dps.program_sort != ''
        THEN dps.program_sort
      ELSE
        '--no programs--'
    END sort_title
  FROM discs d
  LEFT OUTER JOIN (SELECT
                    dp3.*,
                    dp3.program_sort,
                    sp1.series_sort
                  FROM (SELECT
                          dp2.*,
                          CASE
                            WHEN p.sort_name IS NULL OR p.sort_name = ''
                              THEN trim(lower(p.name) || ' ' || p.year)
                            ELSE
                              trim(lower(p.sort_name) || ' ' || p.year)
                          END program_sort
                        FROM
                          (SELECT
                            dp.disc_id,
                            dp.program_type,
                            dp.program_id,
                            CASE dp.program_type
                              WHEN 'FEATURE'
                                THEN 1
                              ELSE 2
                            END type_sort,
                            CASE
                              WHEN dp.sequence IS NOT NULL AND dp.sequence != ''
                                THEN dp.sequence
                              ELSE 100
                            END sequence_sort
                          FROM disc_programs dp
                          ORDER BY dp.disc_id, type_sort, sequence_sort, dp.program_id) dp2
                        LEFT OUTER JOIN programs p ON dp2.program_id = p.id
                        GROUP BY dp2.disc_id) dp3
                  LEFT OUTER JOIN (SELECT
                                    sp.series_id,
                                    sp.program_id,
                                    CASE
                                      WHEN s.name LIKE 'A %'
                                        THEN
                                          lower(substr(s.name, 3))
                                      WHEN s.name LIKE 'An %'
                                        THEN
                                          lower(substr(s.name, 4))
                                      WHEN s.name LIKE 'The %'
                                        THEN
                                          lower(substr(s.name, 5))
                                      ELSE
                                        lower(s.name)
                                    END series_sort
                                  FROM
                                    series_programs sp
                                  LEFT OUTER JOIN series s ON sp.series_id = s.id
                                  GROUP BY sp.series_id) sp1 ON dp3.program_id = sp1.program_id) dps ON d.id = dps.disc_id
  LEFT OUTER JOIN (SELECT
                    dpkg.disc_id,
                    dpkg.package_id,
                    CASE
                      WHEN pkg.name LIKE 'A %'
                        THEN
                          lower(substr(pkg.name, 3))
                      WHEN pkg.name LIKE 'An %'
                        THEN
                          lower(substr(pkg.name, 4))
                      WHEN pkg.name LIKE 'The %'
                        THEN
                          lower(substr(pkg.name, 5))
                      ELSE
                        lower(pkg.name)
                    END package_sort
                    FROM
                    disc_packages dpkg
                    LEFT OUTER JOIN packages pkg ON dpkg.package_id = pkg.id) dpkg1 ON d.id = dpkg1.disc_id
  ORDER BY sort_title
  SQL
end
