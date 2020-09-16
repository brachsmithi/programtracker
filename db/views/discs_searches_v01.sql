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
;