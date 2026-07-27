SELECT DISTINCT viewer_id
FROM (
    SELECT viewer_id
    FROM playground.views
    GROUP BY viewer_id, view_date
    HAVING COUNT(DISTINCT article_id) > 1
) AS multi_view_days
ORDER BY viewer_id