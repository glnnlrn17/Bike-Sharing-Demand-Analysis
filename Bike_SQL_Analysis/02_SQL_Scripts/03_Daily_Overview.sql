-- @name yearly_summary
SELECT year_label, COUNT(*) AS days, SUM(cnt) AS total_rentals, ROUND(AVG(cnt), 0) AS avg_daily, SUM(casual) AS casual, SUM(registered) AS registered, ROUND(100.0 * SUM(casual) / SUM(cnt), 1) AS casual_pct FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY year_label ORDER BY year_label;

-- @name monthly_trend
SELECT year_label, month_num, COUNT(*) AS days, ROUND(AVG(cnt), 0) AS avg_daily, SUM(cnt) AS total_rentals FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY year_label, month_num ORDER BY year_label, month_num;

-- @name weekday_profile
SELECT weekday_num, weekday_name, ROUND(AVG(cnt), 0) AS avg_daily, ROUND(AVG(casual), 0) AS avg_casual, ROUND(AVG(registered), 0) AS avg_registered FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY weekday_num, weekday_name ORDER BY weekday_num;

-- @name daytype_comparison
SELECT daytype, COUNT(*) AS days, ROUND(AVG(cnt), 0) AS avg_daily, ROUND(AVG(casual), 0) AS avg_casual, ROUND(AVG(registered), 0) AS avg_registered, ROUND(100.0 * SUM(casual) / SUM(cnt), 1) AS casual_pct FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY daytype;

-- @name season_summary
SELECT season, COUNT(*) AS days, SUM(cnt) AS total_rentals, ROUND(AVG(cnt), 0) AS avg_daily FROM day_clean WHERE data_quality = 'Complete (24h)' GROUP BY season ORDER BY total_rentals DESC;
