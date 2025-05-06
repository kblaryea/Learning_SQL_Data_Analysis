-- Handling Dates and Times

SELECT job_posted_date
FROM job_postings_fact
Limit 10;


Select '2023-01-01'::date,
        '123' :: integer,
        'true':: boolean,
        '3.14':: real;


select 
    job_title_short as title ,
    job_location as location, 
    job_posted_date:: date as date 
from job_postings_fact;


--convert timestamp to different time zone
select 
    job_title_short as title ,
    job_location as location, 
    job_posted_date at time zone 'UTC' at time zone 'EST'
from job_postings_fact;


-- Extracting things from date, like year, month, day

select 
    job_title_short as title ,
    job_location as location, 
    job_posted_date at time zone 'UTC' at time zone 'EST' as date_time,
    Extract (Month from job_posted_date) as date_month,
    Extract (Year from job_posted_date) as date_year,
    Extract (Day from job_posted_date) as date_day
    from job_postings_fact
limit 5;


--Application. agregate job postings by month for data analyst jobs
SELECT
    extract (month from job_posted_date) as month, 
    count (job_id) as job_posted_count
FROM
    job_postings_fact
WHERE
    job_title_short ILIKE 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count desc;



--Practice Problem 1
Select 
    job_schedule_type,
    avg(salary_year_avg) as avg_yearly_salary,
    avg(salary_hour_avg) as avg_hourly_salary
from 
    job_postings_fact
WHERE job_posted_date > '2023-06-01'
    and job_schedule_type is not null

GROUP BY
    job_schedule_type
HAVING
    avg(salary_year_avg) is not null
    and avg(salary_hour_avg) is not null


-- Practice Problem 2
SELECT
    Extract(month from job_posted_date at time zone 'UTC' at time zone 'America/New_York') as month,
    count(job_id) as job_posted_count
FROM
    job_postings_fact
WHERE
    Extract(year from job_posted_date at time zone 'UTC' at time zone 'America/New_York') = 2023
GROUP BY
    Extract(month from job_posted_date at time zone 'UTC' at time zone 'America/New_York')
ORDER BY
    month;


-- Practice Problem 3
Select
    job_postings_fact.job_id,
    job_postings_fact.company_id,
    company_dim.name as company_name,
    job_postings_fact.job_health_insurance,
    job_postings_fact.job_posted_date
from
    job_postings_fact
left join company_dim 
    on job_postings_fact.company_id = company_dim.company_id
where
    (job_postings_fact.job_posted_date >= '2023-04-01'
    and job_postings_fact.job_posted_date <= '2023-06-30')
    and job_postings_fact.job_health_insurance = 'Yes'; 



--copilot answer
SELECT
    company_dim.name as company_name,
    job_postings_fact.job_id,
    job_postings_fact.job_health_insurance,
    job_postings_fact.job_posted_date
    
FROM
    job_postings_fact
LEFT JOIN
    company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    Extract(quarter from job_posted_date) = 2
    AND Extract(year from job_posted_date) = 2023
    AND job_postings_fact.job_health_insurance = 'Yes';



--Creating Tables from other tables 
Create table january_jobs as
    Select *
    FROM job_postings_fact
    where extract(month from job_posted_date) = 1;
   

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE Extract(month from job_posted_date) = 2;

-- Create table for March jobs
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE Extract(month from job_posted_date) = 3;


-- Case Expressions
-- Case expressions are used to create new columns based on conditions. Apply logic wiithin your SQL queries.

Select
    job_title_short,
    job_location,
    Case
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'Local'
        else 'Onsite'
        
    End as location_category
FROM
    job_postings_fact;


-- Analyze how many jobs are remote, local, or onsite
SELECT
    count(job_id) as number_of_jobs,
    Case
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'Local'
        else 'Onsite'
        
    End as location_category
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category


-- Prratice problem 1 on Case When expressions

Select 
    job_title,
    job_location,
    salary_year_avg,
    Case
        when salary_year_avg <= 100000 then 'Low Salary'
        when salary_year_avg > 100000 and salary_year_avg <= 200000 then 'Medium Salary'
        when salary_year_avg >200000 then 'High Salary'
        else 'Unknown Salary' 

    End as salary_category
FROM job_postings_fact
where job_title_short = 'Data Analyst' and salary_year_avg is not Null 
ORDER BY
    salary_year_avg desc 


/*Subqueries and CTEs
-- Subqueries are queries within queries. They can be used to filter data, create new columns, or perform calculations.
-- CTEs (Common Table Expressions) are temporary result sets that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. They are defined using the WITH clause and can be used to simplify complex queries.
-- CTEs are often used to break down complex queries into smaller, more manageable parts. They can be used to create temporary tables that can be referenced later in the query.
-- CTEs are often used to improve readability and maintainability of SQL code. They can also be used to create recursive queries, which are queries that reference themselves. 
*/


-- Subquery example
Select *
FROM (
    Select *
    From job_postings_fact
    where extract(month from job_posted_date) = 1
) as january_jobs;


-- CTE example
With january_jobs as (
    select *
    from job_postings_fact
    where extract (month from job_posted_date) = 1
)
Select *
From january_jobs;


-- Practice Problem on Subqueries (list of companies that dont have any requirments for a degree)
Select 
    company_id,
    name as company_name
From company_dim
where company_id in (
    Select
        company_id
    From
        job_postings_fact
    where
        job_no_degree_mention  = true
)


/* Practice Problem on CTEs 
Find the companies that have the most job openings.
-Get the total number of job postings per company id
-Return the total number of jobs with the comapny name
*/

With company_job_count as (
    Select 
        company_id, 
        count(*) as total_job_postings
    From 
        job_postings_fact

    Group by
        company_id 
)

Select company_dim.name as company_name,
    company_job_count.total_job_postings
from company_dim
Left join company_job_count
    on company_job_count.company_id = company_dim.company_id
 
ORDER BY
    company_job_count.total_job_postings desc
     


--Practice Problem on CTEs and Subqueries


With skill_count as (
    Select 
        skill_id,
        count(*) as skill_number
    From
        skills_job_dim
    GROUP BY
        skill_id
)

Select skills_dim.skills as skills_name,
    skill_count.skill_number
from skills_dim
Left join skill_count
    on skill_count.skill_id = skills_dim.skill_id

ORDER BY
    skill_count.skill_number desc
LIMIT 5;



-- Identify the top 5 skills most frequently mentioned in job postings (answer from copilot)
SELECT 
    skills_dim.skills AS skill_name,
    skill_count.skill_number
FROM 
    skills_dim
JOIN (
    SELECT 
        skill_id,
        COUNT(*) AS skill_number
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id
    ORDER BY 
        skill_number DESC
    LIMIT 5
) AS skill_count
ON 
    skills_dim.skill_id = skill_count.skill_id
ORDER BY 
    skill_count.skill_number DESC;




    --Practice Problem 2 (Using Subqueries)
Select
    company_dim.name as company_name,
    job_count_category.job_posting_count,
    job_count_category.job_posting_category
From 
    company_dim
Join (
    Select 
        company_id,
        count(*) as job_posting_count,
        Case
            when count(*) <10 then 'Small Company'
            when count(*) >= 10 and count(*) < 50 then 'Medium Company'
            when count(*) >= 50 then 'Large Company'
            else 'Unknown Company Size'
        End as job_posting_category
    From
        job_postings_fact
    GROUP BY
        company_id
) as job_count_category
    on company_dim.company_id = job_count_category.company_id

ORDER BY
    job_count_category.job_posting_count desc;  



    



--Practice Problem 2 (Using CTEs)
 With job_count_category as (
    Select 
        company_id,
        count(*) as job_posting_count,
        Case
            when count(*) <10 then 'Small Company'
            when count(*) >= 10 and count(*) < 50 then 'Medium Company'
            when count(*) >= 50 then 'Large Company'
            else 'Unknown Company Size'
        End as job_posting_category
    From
        job_postings_fact
    GROUP BY
        company_id
 )  
 
Select
    company_dim.name as company_name,
    job_count_category.job_posting_count,
    job_count_category.job_posting_category
From
    company_dim
Left join job_count_category
    on company_dim.company_id = job_count_category.company_id

ORDER BY
    job_count_category.job_posting_count desc;  




--Practice Problem 7 (Advance)
/* Find the count of the number of remonte jobs per skill
-Display the top 5 skills by their demand in remote jobs
-Include skill ID, name, and count of postings requiring the skill
*/




-- Testing a few things first to make sure that job_location coresponds with job_work_from_home
select 
    job_location,
    job_work_from_home
from job_postings_fact
where job_location = 'Anywhere'
    and job_work_from_home <> true
limit 10;




With remote_job_skills as (
    Select
        skills_job_dim.skill_id,
        count (*) as remote_job_count
        
    From 
        job_postings_fact
    join skills_job_dim
        on job_postings_fact.job_id = skills_job_dim.job_id
    where job_location = 'Anywhere' 
    Group by skills_job_dim.skill_id
)


Select 
   remote_job_skills.skill_id,
   skills_dim.skills as skill_name,
   remote_job_skills.remote_job_count
   
From
    remote_job_skills
Left join skills_dim
        on remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
    remote_job_skills.remote_job_count desc
LIMIT 5;




-- Alternative solution using job_work_from_home

With remote_job_skills as (
    Select
        skills_job_dim.skill_id,
        count (*) as remote_job_count
        
    From 
        job_postings_fact
    join skills_job_dim
        on job_postings_fact.job_id = skills_job_dim.job_id
    where job_postings_fact.job_work_from_home = true
        
    Group by skills_job_dim.skill_id
)


Select 
   remote_job_skills.skill_id,
   skills_dim.skills as skill_name,
   remote_job_skills.remote_job_count
   
From
    remote_job_skills
join skills_dim
        on remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
    remote_job_skills.remote_job_count desc

LIMIT 5;




--Using Union Operators
-- The UNION operator is used to combine the result sets of two or more SELECT statements.
-- The result set will include all unique rows from both queries.
-- The UNION ALL operator is used to combine the result sets of two or more SELECT statements, including duplicates.



--First, get jobs and companies from january table
Select 
    job_title_short,
    company_id,
    job_location
from 
    january_jobs

UNION

--Then, get jobs and companies from february table

Select 
    job_title_short,
    company_id,
    job_location
from 
    february_jobs

UNION
--Then, get jobs and companies from march table
Select 
    job_title_short,
    company_id,
    job_location
from
    march_jobs




--Using UNION ALL
--First, get jobs and companies from january table
Select 
    job_title_short,
    company_id,
    job_location
from 
    january_jobs

UNION all

--Then, get jobs and companies from february table

Select 
    job_title_short,
    company_id,
    job_location
from 
    february_jobs

UNION all
--Then, get jobs and companies from march table
Select 
    job_title_short,
    company_id,
    job_location
from
    march_jobs



/*
Find job postings from the first quarter 2023 that have a salary greater than $70,000
- Combine job posting tables from the first quarter of 2023 (Jan-mar)
- Gets job positings with an average yearly salary > $70,000

*/

Select 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date,
    quarter1_job_postings.salary_year_avg
From( 
    Select *
    From january_jobs
    UNION ALL
    Select *
    From february_jobs
    Union all
    Select *
    From march_jobs

) as quarter1_job_postings

where quarter1_job_postings.salary_year_avg > 70000 
    and quarter1_job_postings.job_title_short = 'Data Analyst'

Order BY
    quarter1_job_postings.salary_year_avg desc;
    



--Practice Problem 1 (Union Operators)





Select 
    quarter1_job_skills.job_id,
    quarter1_job_skills.job_title_short,
    quarter1_job_skills.job_location,
    skills_job_dim.skill_id,
    skills_dim.skills as skill_name,
    quarter1_job_skills.salary_year_avg

From (
    Select 
        job_id,
        job_title_short,
        job_location,
        salary_year_avg
    from january_jobs
    UNION ALL
    Select 
        job_id,
        job_title_short,
        job_location,
        salary_year_avg
    from february_jobs
    UNION ALL
    Select 
        job_id,
        job_title_short,
        job_location,
        salary_year_avg
    from march_jobs
  ) as quarter1_job_skills

Left join skills_job_dim
    on quarter1_job_skills.job_id = skills_job_dim.job_id
Left join skills_dim
    on skills_job_dim.skill_id = skills_dim.skill_id

Where quarter1_job_skills.job_title_short = 'Data Analyst'
    and quarter1_job_skills.salary_year_avg > 70000

order BY
    quarter1_job_skills.salary_year_avg desc