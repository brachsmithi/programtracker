SELECT
  p.*,
  ps.sort_title,
  CASE
    WHEN at.search_name IS NOT NULL AND at.search_name != ''
      THEN 
		    CASE
			    WHEN ps.sort_title NOT LIKE lower(p.name) || '%'
				    THEN lower(p.name) || ' ' || ps.sort_title || ' ' || at.search_name
			    ELSE  ps.sort_title || ' ' || at.search_name
		    END
    ELSE
	    CASE
		    WHEN ps.sort_title NOT LIKE lower(p.name) || '%'
		      THEN lower(p.name) || ' ' || ps.sort_title
		    ELSE ps.sort_title
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
                  THEN lower(sort_name) || '  ' || year
                ELSE lower(name) || '  ' || year
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
ORDER BY sort_title
;