# Filtering Students in Active Clubs

Given tables `clubs` (id: unique club id, name: club name) and `students` (id: unique student id, name: student name, club_id: club's id), return a list from the students table for those who are in clubs that still exist in the clubs table. The result should have three columns (id, name, club_id) and be sorted by students' ids (id), and include only those students whose club_id matches an id in the clubs table.

**Difficulty:** easy

## Tables

`playground.clubs`
| Column | Type |
|---|---|
| id | int |
| name | string |

`playground.students`
| Column | Type |
|---|---|
| id | int |
| name | string |
| club_id | int |

## Expected output columns

| Column | Type |
|---|---|
| id | integer |
| name | varchar |
| club_id | integer |