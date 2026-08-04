# Identifying Empty Departments

Given two tables, `playground.employees` and `playground.departments`, with employees containing id, full_name, and department, and departments containing id (unique department ID) and dep_name (department name), write a SQL query to build a table with one column, dep_name. This table should list all the departments that currently have no employees, sorted by the department id.

**Difficulty:** easy

## Tables

`playground.employees`
| Column | Type |
|---|---|
| id | int |
| full_name | string |
| department | int |

`playground.departments`
| Column | Type |
|---|---|
| id | int |
| dep_name | string |

## Expected output columns

| Column | Type |
|---|---|
| dep_name | varchar |