# Check Test Answers

Create a SQL query to evaluate test answers stored in a table named `playground.answers` with columns id (unique question ID), correct_answer (string), and given_answer (which can be NULL). Return a table with columns id and checks, where checks is "no answer" if given_answer is NULL, "correct" if given_answer matches correct_answer, and "incorrect" otherwise. Order the results by id.

**Difficulty:** easy

## Table: `playground.answers`

| Column | Type |
|---|---|
| id | int |
| correct_answer | string |
| given_answer | string |

## Expected output columns

| Column | Type |
|---|---|
| id | integer |
| checks | varchar |