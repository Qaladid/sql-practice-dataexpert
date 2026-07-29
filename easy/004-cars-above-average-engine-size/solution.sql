SELECT brand_name, fuel_type, engine_size
FROM playground.automobile
WHERE engine_size > (
    SELECT AVG(engine_size)
    FROM playground.automobile
)
ORDER BY engine_size DESC, brand_name ASC