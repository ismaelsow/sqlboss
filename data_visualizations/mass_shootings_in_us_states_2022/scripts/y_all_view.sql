CREATE OR REPLACE VIEW mass_shootings.y_all_view AS
  (
    WITH all_years AS
      (
        SELECT * FROM mass_shootings.y_2013
        UNION ALL
        SELECT * FROM mass_shootings.y_2014
        UNION ALL
        SELECT * FROM mass_shootings.y_2015
        UNION ALL
        SELECT * FROM mass_shootings.y_2016
        UNION ALL
        SELECT * FROM mass_shootings.y_2017
        UNION ALL
        SELECT * FROM mass_shootings.y_2018
        UNION ALL
        SELECT * FROM mass_shootings.y_2019
        UNION ALL
        SELECT * FROM mass_shootings.y_2020
        UNION ALL
        SELECT * FROM mass_shootings.y_2021
        UNION ALL
        SELECT * FROM mass_shootings.y_2022
      )

    SELECT  incident_date,
            state,
            number_of_killed,
            number_of_injured
      FROM  all_years
  );
