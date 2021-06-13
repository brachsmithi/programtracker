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
;