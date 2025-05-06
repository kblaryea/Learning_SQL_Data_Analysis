/*
Question: What are the most optimal skills to learn (aka its in high demand and a high-paying skill)?
-Identify skills in high demand and associated with high averge salaries for Data Analyst roles
-Concentrate on remote positions with specified salaries (remove nulls).
-Why? Targets skills that offer job security (high demand) and financial benefits (high salary),
offering strategic insight for career development i data analysis.
*/



With skills_demand as (

    Select
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    From job_postings_fact
    JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    where
        job_title_short = 'Data Analyst'
        and salary_year_avg is not Null
        and job_work_from_home = True
    Group BY
        skills_dim.skill_id

   
), average_salary as (
    Select
        skills_job_dim.skill_id,
        round(avg(job_postings_fact.salary_year_avg), 0) as avg_salary
    From job_postings_fact
    JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    where
        job_title_short = 'Data Analyst'
        and salary_year_avg is not Null
        and job_work_from_home = True
    Group BY
        skills_job_dim.skill_id

)  


Select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
From
    skills_demand
JOIN
    average_salary
    on skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10

ORDER BY
    avg_salary DESC,
    demand_count DESC
    

limit 25;