SELECT dep_name
FROM playground.departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM playground.employees e
    WHERE e.department = d.id
)
ORDER BY d.id