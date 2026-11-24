-- @name growth_2012_vs_2011
SELECT ROUND(100.0 * (SUM(CASE WHEN year_label = '2012' THEN cnt END) - SUM(CASE WHEN year_label = '2011' THEN cnt END)) / SUM(CASE WHEN year_label = '2011' THEN cnt END), 1) AS total_growth_pct FROM day_clean WHERE data_quality = 'Complete (24h)';

-- @name busiest_day
SELECT date, weekday_name, weather, cnt AS rentals FROM day_clean WHERE data_quality = 'Complete (24h)' ORDER BY cnt DESC LIMIT 5;

-- @name quietest_day
SELECT date, weekday_name, weather, cnt AS rentals FROM day_clean WHERE data_quality = 'Complete (24h)' ORDER BY cnt ASC LIMIT 5;

-- @name weather_gap
SELECT ROUND(100.0 * (AVG(CASE WHEN weather = 'Clear' THEN cnt END) - AVG(CASE WHEN weather = 'Mist/Cloudy' THEN cnt END)) / AVG(CASE WHEN weather = 'Clear' THEN cnt END), 1) AS clear_vs_mist_pct, ROUND(100.0 * (AVG(CASE WHEN weather = 'Clear' THEN cnt END) - AVG(CASE WHEN weather = 'Light rain/snow' THEN cnt END)) / AVG(CASE WHEN weather = 'Clear' THEN cnt END), 1) AS clear_vs_rain_snow_pct FROM day_clean WHERE data_quality = 'Complete (24h)';

-- @name casual_share_nonworking
SELECT ROUND(100.0 * SUM(CASE WHEN daytype = 'Non-working day' THEN casual END) / SUM(CASE WHEN daytype = 'Non-working day' THEN cnt END), 1) AS casual_share_non_working_pct, ROUND(100.0 * SUM(CASE WHEN daytype = 'Working day' THEN casual END) / SUM(CASE WHEN daytype = 'Working day' THEN cnt END), 1) AS casual_share_working_pct FROM day_clean WHERE data_quality = 'Complete (24h)';
