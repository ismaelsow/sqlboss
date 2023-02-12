CREATE OR REPLACE FUNCTION mass_shootings.state_region(state STRING) AS
  (
    CASE
      WHEN state IN ('Connecticut', 'Delaware', 'District of Columbia', 'Maine', 'Maryland', 'Massachusetts', 'New Hampshire', 'New Jersey', 'New York', 'Pennsylvania', 'Rhode Island', 'Vermont')
        THEN 'Northeast'
      WHEN state IN ('Alabama', 'Arkansas', 'Florida', 'Georgia', 'Kentucky', 'Louisiana', 'Mississippi', 'North Carolina', 'South Carolina', 'Tennessee', 'Virginia', 'West Virginia')
        THEN 'Southeast'
      WHEN state IN ('Illinois', 'Indiana', 'Iowa', 'Kansas', 'Michigan', 'Minnesota', 'Missouri', 'Nebraska', 'North Dakota', 'Ohio', 'South Dakota', 'Wisconsin')
        THEN 'Midwest'
      WHEN state IN ('Arizona', 'New Mexico', 'Oklahoma', 'Texas')
        THEN 'Southwest'
      WHEN state IN ('Alaska', 'California', 'Colorado', 'Hawaii', 'Idaho', 'Montana', 'Nevada', 'Oregon', 'Utah', 'Washington', 'Wyoming')
        THEN 'West'
    END
  );
