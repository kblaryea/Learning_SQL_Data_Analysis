# Introduction
Explore the data job market with a focus on data analyst roles. This project examines the highest-paying positions, the most in-demand skills, and where high demand meets high salaries in the field of data analytics.
🔎 SQL queries? Check them out here: [project_sql folder] (/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to understand top-paying and in-demand
skills, to find optimal jobs.
Data used is obtained from my [SQL Course] (https://lukebarousse.com/sql). It's contains insights on job titles, salaries, locations, and essential skills.

### The questions I seek to answer through my SQL queries are: 
1. Whatare the top-paying data analyst jobs?
   
3. Whatskills are required for these top-payingjobs?
   
5. What skills are most in demand for data analysts?
   
7. Which skills are associated with higher salaries?
   
9. What are the most optimal skills to learn?

# Tools I Used
For my deep insight into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and discover critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring
  collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here is how I aproached each question: 
### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field. 
```sql
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
```

Here is a breakdown of top data analyst jobs in 2023:
- **High-paying roles span various seniority levels:** While director and principal roles like Director of Analytics at Meta ($336K) and Principal Data Analyst at SmartAsset ($205K–$186K) are expectedly high-paying, even some mid-level Data Analyst positions, such as one at Mantys, report unusually high salaries ($650K), likely due to niche industry focus or equity-heavy compensation.

- **Remote flexibility is common among top-paying jobs:** All listed roles are open to remote or hybrid arrangements, indicating that high compensation is increasingly compatible with flexible work setups in the data analytics field.

- **Leading tech and finance companies dominate:** Employers offering the highest salaries include major players like Meta, AT&T, Pinterest, and UCLA Health, suggesting that organizations with deep data infrastructure or customer insights needs value data analysts as strategic assets.

# What I Learned
# Conclusions
