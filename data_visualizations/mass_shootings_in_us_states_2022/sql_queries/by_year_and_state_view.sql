CREATE OR REPLACE VIEW mass_shootings.by_year_and_state_view AS
  (
    SELECT    EXTRACT(YEAR FROM PARSE_DATE('%B %d, %Y', incident_date)) AS year,
              state,
              SUM(number_of_killed) AS number_of_killed,
              SUM(number_of_injured) AS number_of_injured,
              SUM(number_of_killed + number_of_injured) AS victims
        FROM  mass_shootings.y_all_view

    GROUP BY  year,
              state

    ORDER BY  year ASC,
              state ASC,
              victims DESC
  );
