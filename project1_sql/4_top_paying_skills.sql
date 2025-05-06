/* 
Question 4: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Analyst roles.
Focuses on roles with specified Salaries, regardless of location.
Why? It reveals how different skills impact salary levels for data analyst and helps
identify the mmost financially rewarding skills to acquire or improve.
*/


Select
    skills,
    round(avg(salary_year_avg), 0) as avg_salary
From job_postings_fact
JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where
    job_postings_fact.job_title_short = 'Data Analyst'
    and salary_year_avg is not Null
Group BY
    skills

Order By
    avg_salary DESC
Limit 25;

/* Here is a breadown of the top 25 skills based on salary for Data Analyst roles:


{
    "skills": "svn",
    "avg_salary": "400000"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "golang",
    "avg_salary": "155000"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500"
  },
  {
    "skills": "terraform",
    "avg_salary": "146734"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820"
  },
  {
    "skills": "keras",
    "avg_salary": "127013"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skills": "perl",
    "avg_salary": "124686"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skills": "notion",
    "avg_salary": "118092"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387"
  },
  {
    "skills": "scala",
    "avg_salary": "115480"
  }
]


-AI & ML Skills Dominate: Tools and frameworks related to machine learning and deep 
learning—such as Solidity, MXNet, Keras, PyTorch, TensorFlow, and Hugging Face—command 
high salaries, reflecting the increasing demand for AI-driven analytics and model deployment.


-DevOps & Cloud Infrastructure Skills Pay Well: Proficiency in infrastructure tools 
like Terraform, Ansible, Puppet, and VMware is highly valued, especially as analytics 
shifts toward scalable, cloud-based environments.


-Niche & Emerging Technologies Offer Premiums: Specialized tools like Couchbase, DataRobot, 
and Kafka signal that companies are willing to pay a premium for expertise in less common but 
powerful data technologies that support high-performance and real-time data systems.

*/