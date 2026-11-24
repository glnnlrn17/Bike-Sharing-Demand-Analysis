# Bike Sharing Demand: SQL Portfolio Project

Analysis of Capital Bikeshare rentals in Washington D.C. for 2011 and 2012 (731 days, 17,379 hourly rows), using the UCI Bike Sharing Dataset.

## Folder guide
- **01_Dataset**: day.csv, hour.csv, the original Readme and the data dictionary.
- **02_SQL_Scripts**: six SQLite scripts, run in order: data quality checks, cleaning, daily overview, weather analysis, hourly patterns, business insights.
- **03_Cleaned_Data**: `day_clean.csv` (731 rows), `hour_clean.csv` (17,379 rows) and the cleaning log.
- **04_Analysis_Results**: one Excel workbook per analysis area.
- **05_Dashboard**: Excel dashboard with five dropdown filters (year, season, weather, day type, data scope), a PDF export and a screenshot. The Looker Studio link is not published (see `Dashboard_Link.txt`).
- **06_Project_Documentation**: this README, the final report (PDF) and business recommendations (Word).

## Headline results (complete days, n = 655)
- Total rentals rose 75.7% from 2011 to 2012. Average daily rentals went from 3,731 to 5,712.
- Casual riders are 19.1% of rentals. On non-working days they are 31.8%, against 13.4% on working days.
- Clear days average 5,128 rentals. Misty or cloudy days average 15.5% less, and light rain or snow days 61.3% less.
- Fall is the busiest season (5,718 a day). Spring is the quietest (3,012).
- Working-day demand peaks at 17:00. Non-working days peak at 13:00.

## Data notes
- 76 of 731 days have fewer than 24 hourly rows (165 hours missing in total). The day totals match the partial hourly rows, so those days are understated. Daily analysis uses the 655 complete days; the dashboard can include the rest.
- The hourly analysis uses all recorded hours and is not affected by the scope filter.
- Weather code 4 (heavy rain or snow) appears in only 3 hourly rows, so it is labelled but not analysed.
- Temperature, feels-like temperature, humidity and wind are stored in the dataset as normalised values. The cleaned data converts them using the scaling in the Readme (×41, ×50, ×100, ×67). The Readme does not state the wind-speed unit.
- These are patterns in one city over two years. Weather and day type are linked, so their effects are not independent.
