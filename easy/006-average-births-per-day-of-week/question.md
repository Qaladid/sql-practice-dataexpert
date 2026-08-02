# Average Number of Births by Day of the Week

Create a SQL query that finds the average number of births for each day of the week across all years in the `playground.us_birth_stats` table. Cast the average as an integer. Order the results by the day of the week.

**Difficulty:** easy

## Table: `playground.us_birth_stats`

| Column | Type |
|---|---|
| year | int |
| month | int |
| date_of_month | int |
| day_of_week | int |
| births | int |

## Expected output columns

| Column | Type |
|---|---|
| day_of_week | integer |
| average_births | integer |