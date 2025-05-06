/*
Question: What are the most in-demand skills for data analyst jobs?
-Join job postings to inner join table similar to query 2
Identify the top 5 in-demand skills for a data analyst role.
-Focus on all job postings.
-Why? Retrieves insight into the most valuable skills for job seekers. 
*/


Select
    skills,
    count(skills_job_dim.job_id) as demand_count
From job_postings_fact
JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where
    job_postings_fact.job_title_short = 'Data Analyst'
Group BY
    skills

Order By
    demand_count DESC
Limit 5;