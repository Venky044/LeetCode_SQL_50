--       Consecutive Numbers

-- Table: Logs
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- In SQL, id is the primary key for this table.
-- id is an autoincrement column.
 
-- Problem:
-- Find all numbers that appear at least three times consecutively.
-- Return the result table in any order.

-- The result format is in the following example.
-- Example 1:

-- Input: 
-- Logs table:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.

-- Solution:
select
    distinct(l1.num) as ConsecutiveNums
from Logs l1
    inner join
    Logs l2 on l1.id+1 = l2.id and l1.num = l2.num
    inner join 
    Logs l3 on l2.id+1 = l3.id and l2.num = l3.num;

-- or
-- using window functions lag() & lead()
with con_nums as (
    select id, 
        num as cur_num,
        lag(num) over(order by id) as pre_num,
        lead(num) over(order by id) as next_num
    from Logs
)

select 
    distinct(cur_num) as ConsecutiveNums
from con_nums
where cur_num = pre_num and cur_num = next_num;
