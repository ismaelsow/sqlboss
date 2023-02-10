CREATE OR REPLACE VIEW mass_shootings.victims_per_1m_by_year_and_state_view AS
  (
    WITH subquery AS
     (
       SELECT       b.year,
                    b.state,
                    mass_shootings.state_region(b.state) AS region,
                    ROUND(u.population / 1000000, 1) AS population_in_m,
                    ROUND(b.victims / (u.population / 1000000), 1) AS victims_per_1m
       
       FROM         mass_shootings.by_year_and_state_view AS b
       INNER JOIN   mass_shootings.us_state_population_totals AS u
       ON           b.year = u.year AND b.state = u.state
     )

     SELECT    *
       FROM    subquery
     ORDER BY year ASC
  );
