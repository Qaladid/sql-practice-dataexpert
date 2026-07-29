# Cars with Above Average Engine Size

Using the table `playground.automobile`, create a SQL query to identify cars that have an engine size above the average across all cars in the dataset. The result should include the brand, fuel_type, and engine size, ordered by engine size in descending order and then brand_name in ascending order.

**Difficulty:** easy

## Table: `playground.automobile`

| Column | Type |
|---|---|
| brand_name | string |
| fuel_type | string |
| aspiration | string |
| door_panel | string |
| design | string |
| wheel_drive | string |
| engine_location | string |
| engine_type | string |
| cylinder_count | string |
| engine_size | int |
| fuel_system | string |
| bore | double |
| stroke | double |
| compression_ratio | double |
| horse_power | int |
| top_RPM | int |
| city_mileage | int |
| highway_mileage | int |
| price_in_dollars | int |

## Expected output columns

| Column | Type |
|---|---|
| brand_name | varchar |
| fuel_type | varchar |
| engine_size | integer |