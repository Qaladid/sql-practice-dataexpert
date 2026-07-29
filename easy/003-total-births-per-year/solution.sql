SELECT year, SUM(births) AS total_births
FROM playground.us_birth_stats
GROUP BY year
ORDER BY year