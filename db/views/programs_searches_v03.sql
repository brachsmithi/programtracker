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
;
