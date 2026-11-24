-- @name row_counts
SELECT (SELECT COUNT(*) FROM day_raw) AS day_rows, (SELECT COUNT(*) FROM hour_raw) AS hour_rows;

-- @name null_checks
SELECT SUM(CASE WHEN dteday IS NULL OR cnt IS NULL THEN 1 ELSE 0 END) AS day_null_key_rows FROM day_raw;

-- @name duplicate_dates
SELECT (SELECT COUNT(*) - COUNT(DISTINCT dteday) FROM day_raw) AS duplicate_days, (SELECT COUNT(*) - COUNT(DISTINCT dteday || '-' || hr) FROM hour_raw) AS duplicate_hours;

-- @name total_reconciliation
SELECT SUM(CASE WHEN cnt <> casual + registered THEN 1 ELSE 0 END) AS day_mismatch, (SELECT SUM(CASE WHEN cnt <> casual + registered THEN 1 ELSE 0 END) FROM hour_raw) AS hour_mismatch FROM day_raw;

-- @name weekday_check
SELECT SUM(CASE WHEN CAST(strftime('%w', dteday) AS INTEGER) <> weekday THEN 1 ELSE 0 END) AS weekday_mismatch_days FROM day_raw;

-- @name missing_hours
SELECT (SELECT COUNT(*) FROM day_raw) * 24 - (SELECT COUNT(*) FROM hour_raw) AS missing_hour_rows;

-- @name hours_per_day
SELECT n_hours, COUNT(*) AS days FROM (SELECT dteday, COUNT(*) AS n_hours FROM hour_raw GROUP BY dteday) GROUP BY n_hours ORDER BY n_hours;

-- @name day_vs_hour_totals
SELECT SUM(CASE WHEN h.s <> d.cnt THEN 1 ELSE 0 END) AS days_where_totals_differ FROM day_raw d JOIN (SELECT dteday, SUM(cnt) AS s FROM hour_raw GROUP BY dteday) h ON h.dteday = d.dteday;

-- @name weather_codes_hourly
SELECT weathersit, COUNT(*) AS hours FROM hour_raw GROUP BY weathersit ORDER BY weathersit;
