/*
Question: What are the  top-paying data analyst jobs?
-Identify the top 10 highest-paying Data Analyst roles that are available remotely.
-Focuses on job postings with specified salaries (remove nulls).
-Why? Highlight the top-paying opportunities for data analysts, offering insight into employment trends and salary expectations.

*/

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
Limit (10);



/*