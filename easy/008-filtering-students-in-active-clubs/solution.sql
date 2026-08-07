SELECT s.id, s.name, s.club_id
FROM playground.students s
WHERE EXISTS (
    SELECT 1
    FROM playground.clubs c
    WHERE c.id = s.club_id
)
ORDER BY s.id