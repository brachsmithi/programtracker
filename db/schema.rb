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

ActiveRecord::Schema.define(version: 2021_06_13_192206) do

  create_table "alternate_titles", force: :cascade do |t|
    t.string "name"
    t.integer "program_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_alternate_titles_on_program_id"
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
    t.boolean "filled"
  end

  create_table "package_packages", force: :cascade do |t|
    t.integer "wrapper_package_id", null: false
    t.integer "contained_package_id", null: false
    t.integer "sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contained_package_id"], name: "index_package_packages_on_contained_package_id"
    t.index ["wrapper_package_id"], name: "index_package_packages_on_wrapper_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "person_aliases", force: :cascade do |t|
    t.string "name"
    t.integer "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_person_aliases_on_person_id"
  end

  create_table "persons", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "program_persons", id: false, force: :cascade do |t|
    t.integer "program_id", null: false
    t.integer "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_program_persons_on_person_id"
    t.index ["program_id"], name: "index_program_persons_on_program_id"
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

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "series_discs", force: :cascade do |t|
    t.integer "series_id", null: false
    t.integer "disc_id", null: false
    t.integer "sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["disc_id"], name: "index_series_discs_on_disc_id"
    t.index ["series_id"], name: "index_series_discs_on_series_id"
  end

  create_table "series_packages", force: :cascade do |t|
    t.integer "series_id", null: false
    t.integer "package_id", null: false
    t.integer "sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["package_id"], name: "index_series_packages_on_package_id"
    t.index ["series_id"], name: "index_series_packages_on_series_id"
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

  create_table "series_series", force: :cascade do |t|
    t.integer "wrapper_series_id", null: false
    t.integer "contained_series_id", null: false
    t.integer "sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contained_series_id"], name: "index_series_series_on_contained_series_id"
    t.index ["wrapper_series_id"], name: "index_series_series_on_wrapper_series_id"
  end

  add_foreign_key "alternate_titles", "programs"
  add_foreign_key "disc_packages", "discs"
  add_foreign_key "disc_packages", "packages"
  add_foreign_key "disc_programs", "discs"
  add_foreign_key "disc_programs", "programs"
  add_foreign_key "discs", "locations"
  add_foreign_key "package_packages", "packages", column: "contained_package_id"
  add_foreign_key "package_packages", "packages", column: "wrapper_package_id"
  add_foreign_key "person_aliases", "persons"
  add_foreign_key "program_persons", "persons"
  add_foreign_key "program_persons", "programs"
  add_foreign_key "programs", "program_version_clusters"
  add_foreign_key "series_discs", "discs"
  add_foreign_key "series_discs", "series"
  add_foreign_key "series_packages", "packages"
  add_foreign_key "series_packages", "series"
  add_foreign_key "series_programs", "programs"
  add_foreign_key "series_programs", "series"
  add_foreign_key "series_series", "series", column: "contained_series_id"
  add_foreign_key "series_series", "series", column: "wrapper_series_id"

  create_view "packages_searches", sql_definition: <<-SQL
    		SELECT
															p.*,
															p.name AS display_title,
														  CASE
														    WHEN p.name LIKE 'A %'
														      THEN lower(substr(p.name, 3))
														    WHEN p.name LIKE 'An %'
														      THEN lower(substr(p.name, 4))
														    WHEN p.name LIKE 'The %'
														      THEN lower(substr(p.name, 5))
														    ELSE lower(p.name)
														  END sort_title,
														  CASE
														    WHEN dps.search_name IS NOT NULL AND dps.search_name != ''
														      THEN dps.search_name
														    ELSE
														      lower(p.name)
														  END search_name
														FROM packages p
														LEFT OUTER JOIN (SELECT
														                dp.*,
														                ds.*,
														                GROUP_CONCAT(ds.search_name)
														              FROM disc_packages dp
														              LEFT OUTER JOIN discs_searches ds ON dp.disc_id = ds.id
														              GROUP BY dp.package_id) dps ON dps.package_id = p.id
														ORDER BY sort_title
  SQL
  create_view "programs_searches", sql_definition: <<-SQL
      SELECT
        p.*,
        ps.sort_title,
        sp2.series_name,
        dpkg.search_name AS search_fragment,
        CASE
          WHEN at.search_name IS NOT NULL AND at.search_name != ''
            THEN 
      		CASE
      	      WHEN ps.sort_title NOT LIKE lower(p.name) || '%'
      	        THEN
      	          CASE
      	            WHEN sp2.series_name IS NOT NULL AND sp2.series_name != ''
      	              THEN
      	                CASE
      	                  WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      	                    THEN lower(p.name) || ' ' || ps.sort_title || ' ' || at.search_name || ' ' || lower(sp2.series_name) || ' ' || dpkg.search_name
      	                  ELSE lower(p.name) || ' ' || ps.sort_title || ' ' || at.search_name || ' ' || lower(sp2.series_name)
      			        END
      			    ELSE
      			      CASE
      			        WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      			          THEN lower(p.name) || ' ' || ps.sort_title || ' ' || at.search_name || ' ' || dpkg.search_name
      			        ELSE
      			         lower(p.name) || ' ' || ps.sort_title || ' ' || at.search_name
      			      END
      			  END
      		  ELSE
      		    CASE
      		      WHEN sp2.series_name IS NOT NULL AND sp2.series_name != ''
      		        THEN
      		          CASE
      		            WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      		              THEN ps.sort_title || ' ' || at.search_name || ' ' || lower(sp2.series_name) || ' ' || dpkg.search_name
      		            ELSE
      		              ps.sort_title || ' ' || at.search_name || ' ' || lower(sp2.series_name)
      		          END
      		      ELSE
      		        CASE
      		          WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      		            THEN ps.sort_title || ' ' || at.search_name || ' ' || dpkg.search_name
      		          ELSE
      		            ps.sort_title || ' ' || at.search_name
      		        END
      		    END
      		END
          ELSE
      	  CASE
      		WHEN ps.sort_title NOT LIKE lower(p.name) || '%'
      		  THEN
      		    CASE
      		      WHEN sp2.series_name IS NOT NULL AND sp2.series_name != ''
      		        THEN
      		          CASE
      		            WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      		              THEN lower(p.name) || ' ' || ps.sort_title || ' ' || lower(sp2.series_name) || ' ' || dpkg.search_name
      		            ELSE
      		              lower(p.name) || ' ' || ps.sort_title || ' ' || lower(sp2.series_name)
      		          END
      		      ELSE
      		        CASE
      		          WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      		            THEN lower(p.name) || ' ' || ps.sort_title || ' ' || dpkg.search_name
      		          ELSE
      		            lower(p.name) || ' ' || ps.sort_title
      		        END
      		    END
      		ELSE
      		  CASE
      		    WHEN sp2.series_name IS NOT NULL AND sp2.series_name != ''
      		      THEN
      		        CASE
      		          WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      		           THEN ps.sort_title || ' ' || lower(sp2.series_name) || ' ' || dpkg.search_name
      		          ELSE ps.sort_title || ' ' || lower(sp2.series_name)
      		        END
      		    ELSE
      		      CASE
      		        WHEN dpkg.search_name IS NOT NULL AND dpkg.search_name != ''
      		          THEN ps.sort_title || ' ' || dpkg.search_name
      		        ELSE
      		          ps.sort_title
      		      END
      		  END
      	END
        END search_name
      FROM programs p
      JOIN (
            SELECT
              id,
              CASE
                WHEN year IS NOT NULL AND year != ''
                  THEN
                    CASE
                      WHEN sort_name IS NOT NULL AND sort_name != ''
                        THEN lower(sort_name) || ' ' || year
                      ELSE lower(name) || ' ' || year
                    END
                ELSE 
                  CASE
                    WHEN sort_name IS NOT NULL AND sort_name != ''
                      THEN lower(sort_name)
                    ELSE lower(name)
                  END
              END sort_title
            FROM programs
            ) ps ON p.id = ps.id
      LEFT OUTER JOIN (
                        SELECT
                          *,
                          group_concat(lower(name), ' ') AS search_name
                        FROM alternate_titles
                        GROUP BY program_id
                      ) at ON p.id = at.program_id
      LEFT OUTER JOIN (
                        SELECT
                          inner_sp2.program_id,
                          group_concat(lower(inner_sp2.name), ' ') AS series_name
                        FROM (
                          SELECT
                              sp1.series_id,
                              sp1.program_id,
                              s.name
                          FROM series_programs sp1
                          LEFT OUTER JOIN (
                                            SELECT
                                              id,
                                              name
                                            FROM series
                        ) s ON sp1.series_id = s.id) inner_sp2
                        GROUP BY inner_sp2.program_id
                      ) sp2 ON p.id = sp2.program_id
      LEFT OUTER JOIN (
                       SELECT
                         inner_dpkg.program_id,
                         group_concat(inner_dpkg.search_name, ' ') AS search_name
                       FROM (
                         SELECT
                           d.id,
                           d.name AS disc_name,
                           dp.package_id,
                           pkg.name AS package_name,
                           dprog.program_id,
                           CASE
                             WHEN d.name IS NOT NULL AND d.name != ''
                               THEN
                                 CASE
                                   WHEN lower(d.name) IN (
                                                          'disc 1',
                                                          'disc 2',
                                                          'disc 3',
                                                          'disc 4',
                                                          'disc 5',
                                                          'disc 6',
                                                          'disc 7',
                                                          'disc 8',
                                                          'disc 9',
                                                          'disc 10',
                                                          'disc 11',
                                                          'disc 12',
                                                          'disc 13',
                                                          'disc 14',
                                                          'disc 15',
                                                          'disc one',
                                                          'disc two',
                                                          'disc three',
                                                          'disc four',
                                                          'disc five',
                                                          'disc six',
                                                          'disc seven',
                                                          'disc eight',
                                                          'disc nine',
                                                          'disc ten',
                                                          'disc eleven',
                                                          'disc twelve',
                                                          'disc thirteen',
                                                          'disc fourteen',
                                                          'disc fifteen'
                                                          )
                                     THEN
                                      CASE
                                        WHEN pkg.name IS NOT NULL AND pkg.name != ''
                                          THEN lower(pkg.name)
                                        ELSE ''
                                      END
                                   ELSE
                                     CASE
                                       WHEN pkg.name IS NOT NULL AND pkg.name != ''
                                         THEN lower(pkg.name) || ' ' || lower(d.name)
                                       ELSE
                                         lower(d.name)
                                     END
                                   END
                             ELSE
                               CASE
                                 WHEN pkg.name IS NOT NULL AND pkg.name != ''
                                   THEN lower(pkg.name)
                                 ELSE ''
                               END
                             END search_name
                           FROM discs d
                           LEFT OUTER JOIN (
                                            SELECT
                                              disc_id,
                                              package_id
                                            FROM disc_packages
                                           ) dp ON d.id = dp.disc_id
                           LEFT OUTER JOIN (
                                            SELECT
                                             id,
                                             name
                                            FROM packages
                                           ) pkg ON dp.package_id = pkg.id
                           LEFT OUTER JOIN (
                                            SELECT
                                              disc_id,
                                              program_id
                                            FROM disc_programs
                                           ) dprog ON d.id = dprog.disc_id) inner_dpkg
                           GROUP BY inner_dpkg.program_id

                       ) dpkg ON p.id = dpkg.program_id
      ORDER BY sort_title
  SQL
  create_view "discs_searches", sql_definition: <<-SQL
      SELECT
      d.*,
      dps.program_name,
      dps.program_type,
      dpkg1.package_name,
      dps.series_name,
      CASE
          WHEN dpkg1.package_sort IS NOT NULL AND dpkg1.package_sort != ''
              THEN
              CASE
                  WHEN dps.search_name IS NOT NULL AND dps.search_name != ''
                      THEN dpkg1.package_sort || ' ' || dps.search_name
                  ELSE dpkg1.package_sort
                  END
          ELSE
              CASE
                  WHEN dps.search_name IS NOT NULL AND dps.search_name != ''
                      THEN dps.search_name
                  ELSE ''
                  END
          END search_name,
      CASE
          WHEN d.name IS NOT NULL AND trim(d.name) != ''
              THEN d.name
          WHEN dps.program_name IS NOT NULL AND dps.program_name != '' AND dps.program_type = 'FEATURE'
              THEN dps.program_name
          WHEN dpkg1.package_name IS NOT NULL AND dpkg1.package_name != ''
              THEN dpkg1.package_name
          WHEN dps.series_name IS NOT NULL AND dps.series_name != ''
              THEN dps.series_name
          WHEN dps.program_name IS NOT NULL AND dps.program_name != ''
              THEN dps.program_name
          ELSE
              '--No Programs--'
          END display_title,
      CASE
          WHEN dpkg1.package_sort IS NOT NULL AND dpkg1.package_sort != ''
              THEN
              CASE
                  WHEN d.name IS NOT NULL AND trim(d.name) != ''
                      THEN
                      CASE
                          WHEN d.name LIKE 'A %'
                              THEN dpkg1.package_sort || ' ' || lower(substr(d.name, 3))
                          WHEN d.name LIKE 'An %'
                              THEN dpkg1.package_sort || ' ' || lower(substr(d.name, 4))
                          WHEN d.name LIKE 'The %'
                              THEN dpkg1.package_sort || ' ' || lower(substr(d.name, 5))
                          ELSE dpkg1.package_sort || ' ' || lower(d.name)
                          END
                  WHEN dps.program_sort IS NOT NULL AND dps.program_sort != '' AND dps.program_type = 'FEATURE'
                      THEN dpkg1.package_sort || ' ' || dps.program_sort
                  ELSE dpkg1.package_sort
                  END
          WHEN d.name IS NOT NULL AND trim(d.name) != ''
              THEN
              CASE
                  WHEN d.name LIKE 'A %'
                      THEN lower(substr(d.name, 3))
                  WHEN d.name LIKE 'An %'
                      THEN lower(substr(d.name, 4))
                  WHEN d.name LIKE 'The %'
                      THEN lower(substr(d.name, 5))
                  ELSE lower(d.name)
                  END
          WHEN dps.program_sort IS NOT NULL AND dps.program_sort != '' AND dps.program_type = 'FEATURE'
              THEN dps.program_sort
          WHEN dps.series_sort IS NOT NULL AND dps.series_sort != ''
              THEN dps.series_sort
          WHEN dps.program_sort IS NOT NULL AND dps.program_sort != ''
              THEN dps.program_sort
          ELSE
              '--no programs--'
          END sort_title
  FROM discs d
           LEFT OUTER JOIN (SELECT
                                dp3.program_id,
                                dp3.program_type,
                                dp3.disc_id,
                                dp3.program_sort,
                                dp3.program_name,
                                sp1.series_sort,
                                sp1.series_name,
                                CASE
                                    WHEN sp1.series_sort IS NOT NULL AND sp1.series_sort != ''
                                        THEN dp3.search_name || ' ' || sp1.series_sort
                                    ELSE dp3.search_name
                                    END search_name
                            FROM (SELECT
                                      dp2.*,
                                      p.sort_title AS program_sort,
                                      group_concat(p.search_name, " ") AS search_name,
                                      CASE
                                          WHEN p.year IS NOT NULL AND p.year != ''
                                              THEN p.name || ' (' || p.year || ')'
                                          ELSE p.name
                                          END program_name
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
                                          LEFT OUTER JOIN programs_searches p ON dp2.program_id = p.id
                                  GROUP BY dp2.disc_id) dp3
                                     LEFT OUTER JOIN (SELECT
                                                          sp.series_id,
                                                          sp.program_id,
                                                          s.name AS series_name,
                                                          CASE
                                                              WHEN s.name LIKE 'A %'
                                                                  THEN lower(substr(s.name, 3))
                                                              WHEN s.name LIKE 'An %'
                                                                  THEN lower(substr(s.name, 4))
                                                              WHEN s.name LIKE 'The %'
                                                                  THEN lower(substr(s.name, 5))
                                                              ELSE lower(s.name)
                                                              END series_sort
                                                      FROM
                                                          series_programs sp
                                                              LEFT OUTER JOIN series s ON sp.series_id = s.id
                                                      GROUP BY sp.series_id) sp1 ON dp3.program_id = sp1.program_id) dps ON d.id = dps.disc_id
           LEFT OUTER JOIN (SELECT
                                dpkg.disc_id,
                                dpkg.package_id,
                                pkg.name AS package_name,
                                CASE
                                    WHEN pkg.name LIKE 'A %'
                                        THEN lower(substr(pkg.name, 3))
                                    WHEN pkg.name LIKE 'An %'
                                        THEN lower(substr(pkg.name, 4))
                                    WHEN pkg.name LIKE 'The %'
                                        THEN lower(substr(pkg.name, 5))
                                    ELSE lower(pkg.name)
                                    END package_sort
                            FROM
                                disc_packages dpkg
                                    LEFT OUTER JOIN packages pkg ON dpkg.package_id = pkg.id) dpkg1 ON d.id = dpkg1.disc_id
  ORDER BY sort_title
  SQL
end
