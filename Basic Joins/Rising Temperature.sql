-- 	Rising Temperature

-- Table: Weather
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | recordDate    | date    |
-- | temperature   | int     |
-- +---------------+---------+
-- In SQL, id is the primary key for this table.
-- This table contains information about the temperature on a certain day.
--  
-- Problem:
-- Find all dates' Id with higher temperatures compared to its previous dates (yesterday).
-- Return the result table in any order.

-- The result format is in the following example.
-- Example 1:

-- Input: 
-- Weather table:
-- +----+------------+-------------+
-- | id | recordDate | temperature |
-- +----+------------+-------------+
-- | 1  | 2015-01-01 | 10          |
-- | 2  | 2015-01-02 | 25          |
-- | 3  | 2015-01-03 | 20          |
-- | 4  | 2015-01-04 | 30          |
-- +----+------------+-------------+
-- Output: 
-- +----+
-- | id |
-- +----+
-- | 2  |
-- | 4  |
-- +----+
-- Explanation: 
-- In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
-- In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

-- Solution:
select t1.id
from Weather t1, Weather t2
where t1.temperature > t2.temperature and
      datediff(t1.recordDate, t2.recordDate) = 1;
      
-- or
select t1.id
from Weather t1
	inner join 
    Weather t2 on datediff(t1.recordDate, t2.recordDate) = 1 
				and t1.temperature > t2.temperature;