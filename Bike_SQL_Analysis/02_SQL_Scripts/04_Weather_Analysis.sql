-- @name weather_summary
SELECT weather, COUNT(*) AS days, ROUND(AVG(cnt), 0) AS avg_daily, ROUND(AVG(temp_c), 1) AS avg_temp_c, ROUND(AVG(humidity_pct), 1) AS avg_humidity FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY weather ORDER BY avg_daily DESC;

-- @name temperature_bands
SELECT CASE WHEN temp_c < 10 THEN '1. Under 10C' WHEN temp_c < 20 THEN '2. 10-19C' WHEN temp_c < 30 THEN '3. 20-29C' ELSE '4. 30C and over' END AS temp_band, COUNT(*) AS days, ROUND(AVG(cnt), 0) AS avg_daily FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY temp_band ORDER BY temp_band;

-- @name humidity_bands
SELECT CASE WHEN humidity_pct < 50 THEN '1. Under 50%' WHEN humidity_pct < 70 THEN '2. 50-69%' WHEN humidity_pct < 85 THEN '3. 70-84%' ELSE '4. 85% and over' END AS humidity_band, COUNT(*) AS days, ROUND(AVG(cnt), 0) AS avg_daily FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY humidity_band ORDER BY humidity_band;

-- @name weather_by_season
SELECT season, weather, COUNT(*) AS days, ROUND(AVG(cnt), 0) AS avg_daily FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY season, weather ORDER BY season, weather;
