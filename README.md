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


![Top Paying Roles](https://github.com/user-attachments/assets/cd6c94e1-d163-49ea-b6e0-078689eb2455)

*Bar graph showing a visualization of the salary of the top 10 data analyst roles; ChatGPT generated this graph from my SQL query results*

# What I Learned

**1. Data Manipulation and Querying:**
I have mastered the ability to retrieve, filter, and manipulate data using SQL queries.
Skills like using SELECT, WHERE, GROUP BY, HAVING, and ORDER BY have enabled you to extract meaningful insights from raw data.
I've also learned advanced techniques like CASE statements, JOINs, and subqueries to handle complex data relationships.

**2. Data Analysis and Aggregation:**
I've learned how to analyze data by aggregating it using functions like COUNT, AVG, SUM, and ROUND.
Techniques like creating buckets, categorizing data, and calculating metrics (e.g., demand and average salary) have helped me derive actionable insights.
I’ve explored how to use CTEs (Common Table Expressions) to structure and simplify complex queries for better readability and reusability.

**3. Problem-Solving with Relational Databases:**
I’ve developed the ability to solve real-world problems, such as identifying high-demand skills, categorizing companies, and analyzing job postings.
I’ve learned to work with relational database concepts, including table relationships (JOIN, LEFT JOIN, etc.), and how to combine data from multiple tables effectively.
Debugging and optimizing queries have taught you how to troubleshoot and refine your code for accuracy and performance.

# Conclusions

## 1. Identifying Top-Paying Jobs
This study identifies the top 10 highest-paying Data Analyst jobs that are remote. This query helps job seekers focus on lucrative remote opportunities, providing details like job title, salary, and company name. It highlights the financial potential of remote Data Analyst roles and helps prioritize job applications. Sorting by salary ensures the highest-paying jobs are prioritized. Useful for job seekers targeting high-paying remote positions

## 2. Skills for Top-Paying Jobs
The study also identifies the skills required for the top 10 highest-paying Data Analyst jobs. It reveals the specific skills employers value most for high-paying roles, such as technical tools or programming languages. Helps job seekers tailor their skillset to align with the requirements of top-paying positions. By focusing on the top-paying jobs, the query narrows down the most critical skills.

## 3. Most In-Demand Skills
The study further identifies the top 5 most in-demand skills for Data Analyst roles by counting how often each skill is mentioned in job postings. It highlights the skills that are most frequently required by employers, such as SQL, Python, or Excel. Provides a clear roadmap for job seekers to focus on acquiring the most sought-after skills. Grouping and sorting by demand ensures the most relevant skills are prioritized. Useful for understanding market trends and aligning skill development with employer needs.

## 4. Top-Paying Skills
The study identifies the top 25 skills based on average salary for Data Analyst roles. It reveals which skills are associated with the highest-paying jobs, such as advanced analytics tools or niche technologies. Helps professionals focus on skills that offer the greatest financial rewards. Sorting by average salary ensures the most lucrative skills are highlighted. Ideal for professionals aiming to maximize their earning potential.


## 5. Optimal Skills to Learn
 The study combines demand and salary data to identify the most optimal skills to learn for Data Analyst roles. It focuses on skills that are both in high demand and associated with high salaries, offering a balanced view of job security and financial benefits. Provides strategic insights for career development, helping professionals prioritize skills that offer the best return on investment. Filtering for skills with demand_count > 10 ensures only significant skills are considered. Perfect for professionals planning long-term career growth in data analysis.
