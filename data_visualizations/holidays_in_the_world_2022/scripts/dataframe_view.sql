CREATE OR REPLACE VIEW world_holidays.dataframe_view AS
(
  WITH all_days AS
  (
    SELECT  *
      FROM  UNNEST(GENERATE_DATE_ARRAY(PARSE_DATE('%F','2022-01-01'), PARSE_DATE('%F', '2022-12-31'))) AS date
  ),

  public_holidays AS
  (
    SELECT    date,
              COUNT(*) AS holidays
    FROM      world_holidays.days
    GROUP BY  date
  ),

  holidays AS
  (
    SELECT        all_days.date, COALESCE(public_holidays.holidays, 0) AS holidays
    FROM          all_days
    LEFT JOIN     public_holidays
    ON            all_days.date = public_holidays.date
  )

  SELECT  *
  FROM    holidays
);
