-- @name hourly_profile
SELECT hr, ROUND(AVG(cnt), 0) AS avg_rentals, ROUND(AVG(CASE WHEN daytype = 'Working day' THEN cnt END), 0) AS working_day_avg, ROUND(AVG(CASE WHEN daytype = 'Non-working day' THEN cnt END), 0) AS non_working_avg FROM hour_clean GROUP BY hr ORDER BY hr;

-- @name time_band_summary
SELECT time_band, COUNT(*) AS hours, SUM(cnt) AS total_rentals, ROUND(100.0 * SUM(cnt) / (SELECT SUM(cnt) FROM hour_clean), 1) AS share_pct FROM hour_clean GROUP BY time_band ORDER BY total_rentals DESC;

-- @name peak_hour_by_daytype
SELECT daytype, hr, ROUND(AVG(cnt), 0) AS avg_rentals FROM hour_clean GROUP BY daytype, hr HAVING ROUND(AVG(cnt), 0) = (SELECT MAX(x) FROM (SELECT ROUND(AVG(cnt), 0) AS x FROM hour_clean h2 WHERE h2.daytype = hour_clean.daytype GROUP BY hr)) ORDER BY daytype;
