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
;