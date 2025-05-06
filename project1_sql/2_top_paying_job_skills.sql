/* Question: What skills are required for the top-paying data analyst jobs?
-Use the top 10 highest-paying Data Analyst jobs from the first query.
-Add the specific skills required for these roles.
-Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries. 
*/


With top_paying_jobs as (
    Select
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name as company_name,
        job_posted_date 
    From
        job_postings_fact
    Left join company_dim
        on job_postings_fact.company_id = company_dim.company_id
    Where
        job_title_short = 'Data Analyst'
        and job_location = 'Anywhere'
        and salary_year_avg is not Null

    Order BY
        salary_year_avg desc
LIMIT 10
    
)


Select
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    top_paying_jobs.company_name,
    skills_dim.skills as skill_name
From
    top_paying_jobs
JOIN
    skills_job_dim
    on top_paying_jobs.job_id = skills_job_dim.job_id
JOIN
    skills_dim
    on skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
    top_paying_jobs.salary_year_avg desc


    

