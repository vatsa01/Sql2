Problem 1: Rank Scores

# Write your MySQL query statement below
select score, dense_rank() over(order by score desc) as 'rank' from Scores
order by score desc

# Write your MySQL query statement below
select s1.score, count(distinct s2.score) as 'rank'
from Scores s1 join Scores s2 on s2.score >= s1.score
group by s1.id, s1.score order by s1.score desc

# Write your MySQL query statement below
select s1.score, (select count(distinct s2.score) from Scores s2 
where s2.score >= s1.score) as 'rank'
from Scores s1 order by s1.score desc

Problem 2: Exchange Seats

# Write your MySQL query statement below
select (case 
            when id = (select count(id) from Seat) and id % 2 = 1 then id
            when id % 2 = 0 then id -1
            else id + 1
        end )as id, student from Seat order by id

Problem 3: Tree Node

# Write your MySQL query statement below
select id, case
            when p_id is null then 'Root'
            when id in (select p_id from Tree) and p_id is not null then 'Inner'
            else 'Leaf'
            end as type 
            from Tree

# Write your MySQL query statement below
select id , 'Root' as type from Tree
where p_id is null
union
select id, 'Inner' as type from Tree
where id in (select p_id from Tree where p_id is not null) and p_id is not null
union
select id, 'Leaf' as type from Tree
where id not in (select p_id from Tree where p_id is not null) and p_id is not null

Problem 4 : Deparment Top 3 Salaries

select dname as Department, name as Employee, salary as Salary
from (select d.name as dname, e.name, e.salary,
    dense_rank() over(partition by d.name order by e.salary desc) as rnk
    from Employee e join Department d on e.departmentId = d.id)
as cte
where rnk <= 3
