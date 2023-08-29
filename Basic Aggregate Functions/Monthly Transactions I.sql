--       Monthly Transactions I

-- Table: Transactions
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | country       | varchar |
-- | state         | enum    |
-- | amount        | int     |
-- | trans_date    | date    |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].
 
-- Problem:
-- Write an SQL query to find for each month and country, 
-- the number of transactions and their total amount, 
-- the number of approved transactions and their total amount.

-- Return the result table in any order.

-- The query result format is in the following example.
-- Example 1:

-- Input: 
-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 121  | US      | approved | 1000   | 2018-12-18 |
-- | 122  | US      | declined | 2000   | 2018-12-19 |
-- | 123  | US      | approved | 2000   | 2019-01-01 |
-- | 124  | DE      | approved | 2000   | 2019-01-07 |
-- +------+---------+----------+--------+------------+
-- Output: 
-- +----------+---------+-------------+----------------+--------------------+-----------------------+
-- | month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
-- +----------+---------+-------------+----------------+--------------------+-----------------------+
-- | 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
-- | 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
-- | 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
-- +----------+---------+-------------+----------------+--------------------+-----------------------+

-- Solution:
# Write your MySQL query statement below
select
    t.month,
    t.country, 
    count(t.amount) as trans_count,
    count(if(t.state='approved', t.state, null)) as approved_count,
    sum(t.amount) as trans_total_amount,
    sum(if(t.state='approved', t.amount, 0)) as approved_total_amount
from
    (select country, state, amount, DATE_FORMAT(trans_date, '%Y-%m') as month
    from Transactions) t
group by t.month, country;

-- or
# Write your MySQL query statement below
select
    DATE_FORMAT(trans_date, '%Y-%m') as month,
    country, 
    count(amount) as trans_count,
    count(if(state='approved', state, null)) as approved_count,
    sum(amount) as trans_total_amount,
    sum(if(state='approved', amount, 0)) as approved_total_amount
from
    Transactions
group by month, country;
