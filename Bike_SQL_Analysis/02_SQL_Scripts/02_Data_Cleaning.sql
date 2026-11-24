DROP TABLE IF EXISTS day_clean;
CREATE TABLE day_clean AS
SELECT d.instant AS record_id,
 d.dteday AS date,
 CASE WHEN yr = 0 THEN '2011' ELSE '2012' END AS year_label,
 mnth AS month_num,
 CASE season WHEN 1 THEN 'Spring' WHEN 2 THEN 'Summer' WHEN 3 THEN 'Fall' ELSE 'Winter' END AS season,
 weekday AS weekday_num,
 CASE weekday WHEN 0 THEN 'Sunday' WHEN 1 THEN 'Monday' WHEN 2 THEN 'Tuesday' WHEN 3 THEN 'Wednesday' WHEN 4 THEN 'Thursday' WHEN 5 THEN 'Friday' ELSE 'Saturday' END AS weekday_name,
 CASE WHEN workingday = 1 THEN 'Working day' ELSE 'Non-working day' END AS daytype,
 CASE WHEN holiday = 1 THEN 'Yes' ELSE 'No' END AS holiday,
 CASE weathersit WHEN 1 THEN 'Clear' WHEN 2 THEN 'Mist/Cloudy' WHEN 3 THEN 'Light rain/snow' ELSE 'Heavy rain/snow' END AS weather,
 ROUND(temp * 41, 1) AS temp_c,
 ROUND(atemp * 50, 1) AS feels_c,
 ROUND(hum * 100, 1) AS humidity_pct,
 ROUND(windspeed * 67, 1) AS wind_scaled,
 d.casual, d.registered, d.cnt,
 h.hours_recorded,
 CASE WHEN h.hours_recorded = 24 THEN 'Complete (24h)' ELSE 'Incomplete (<24h)' END AS data_quality
FROM day_raw d
LEFT JOIN (SELECT dteday, COUNT(*) AS hours_recorded FROM hour_raw GROUP BY dteday) h ON h.dteday = d.dteday;

DROP TABLE IF EXISTS hour_clean;
CREATE TABLE hour_clean AS
SELECT instant AS record_id,
 dteday AS date,
 CASE WHEN yr = 0 THEN '2011' ELSE '2012' END AS year_label,
 CASE season WHEN 1 THEN 'Spring' WHEN 2 THEN 'Summer' WHEN 3 THEN 'Fall' ELSE 'Winter' END AS season,
 CASE WHEN workingday = 1 THEN 'Working day' ELSE 'Non-working day' END AS daytype,
 CASE weathersit WHEN 1 THEN 'Clear' WHEN 2 THEN 'Mist/Cloudy' WHEN 3 THEN 'Light rain/snow' ELSE 'Heavy rain/snow' END AS weather,
 hr,
 CASE WHEN hr BETWEEN 6 AND 9 THEN 'Morning peak (6-9)' WHEN hr BETWEEN 16 AND 19 THEN 'Evening peak (16-19)' WHEN hr BETWEEN 10 AND 15 THEN 'Midday (10-15)' WHEN hr BETWEEN 20 AND 23 THEN 'Late evening (20-23)' ELSE 'Night (0-5)' END AS time_band,
 casual, registered, cnt
FROM hour_raw;
