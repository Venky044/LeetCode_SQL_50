--          Second Highest Salary

-- Table: Employee
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the salary of an employee.
 
-- Problem:
--   Write a solution to find the second highest salary from the Employee table.
-- If there is no second highest salary, return null (return None in Pandas).

-- The result format is in the following example.
-- Example 1:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- Output: 
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | 200                 |
-- +---------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- Output: 
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | null                |
-- +---------------------+

-- Solution:
with sample as (
    select 
        salary
    from Employee
    group by salary
)

select
    if(count(t1.salary) > 1, t2.salary, null) as SecondHighestSalary
from sample t1, 
    (
    select
        salary,
        row_number() over(order by salary desc) as rw
    from sample) as t2
where t2.rw = 2;

-- OR
select (
    select 
        distinct salary
    from Employee 
    order by salary desc
    limit 1 offset 1
) as SecondHighestSalary;
