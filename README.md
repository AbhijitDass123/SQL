# Introduction
📊 Exploring the Data Job Market: Focus on Data Analyst Roles
This project delves into the dynamic world of data analyst careers by analyzing:

💰 Top-Paying Job Titles in the data analytics domain

🔥 In-Demand Skills required by employers

📈 Intersection of High Demand & High Salary opportunities

By leveraging SQL for data exploration and analysis, this project uncovers valuable insights into what makes a data analyst role both lucrative and sought after.

🔍 SQL Queries & Scripts
All SQL queries used in this project can be found in the [SQL_project folder](/SQL_Project/)
# Background
This project was created to better understand and navigate the data analyst job market. The goal is to identify the highest-paying roles and most in-demand skills—helping others save time and effort in finding the best career opportunities.
### The key questions explored through my SQL queries include:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What are the most in-demand skills for data analysts in India?
4.Which skills are associated with higher salaries for data analysts in India?
5. What are the most optimal skills to learn?
# Tools I used
To explore the data analyst job market in depth, I utilized a set of essential tools and technologies:

- **SQL** – Served as the core of my analysis, helping me write queries to extract meaningful insights from the data.

- **PostgreSQL** – Used as the database management system to efficiently store, manage, and query job posting data.

- **Visual Studio Code** – My primary code editor for managing the database and running SQL queries seamlessly.

- **Git & GitHub** – Used for version control and collaboration, making it easy to track progress and share SQL scripts and findings.
# The Analysis
Each SQL query in this project was designed to address specific questions about the data analyst job market. 
Here’s my approach to each:
### 1.Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions based on average annual salary and location, with a focus on remote opportunities. This query highlights the most lucrative jobs in the field.
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name  
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'  
    AND job_location = 'Anywhere'     
    AND salary_year_avg IS NOT NULL   
ORDER BY 
    salary_year_avg DESC             
LIMIT 10;    
```
Key Insights from Top Paying Data Analyst Jobs in 2023!!

- **Strong Salary Potential:** Top data analyst roles offer salaries between $184,000 and $650,000, reflecting significant earning opportunities.
- **Diverse Roles & Employers:** Job titles range from Data Analyst to Director of Analytics, with high-paying positions at companies like Meta, AT&T, and SmartAsset across various industries.
- **Remote & Full-Time Positions:** All top-paying jobs are full-time and remote, highlighting the increasing availability of flexible work options in this field.

<img src="Assests\1.top_paying_job.png" alt="Alt text" width="500"/>

*Bar graph visualizing the top 10 skills by frequency among data analyst job postings; this graph was generated using code provided by ChatGPT and implemented in Google Colab.*


### 2. Skills for Top Paying Jobs
To identify the key skills needed for high-paying positions, I combined job posting information with skills data, revealing which abilities employers prioritize for top-compensation roles.
```sql

WITH skills_top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON
        job_postings_fact.company_id=company_dim.company_id
    WHERE
        job_title_short='Data Analyst' AND 
        job_location='Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT skills_top_paying_jobs.*,
    skills_dim.skills
FROM skills_top_paying_jobs
INNER JOIN skills_job_dim ON
 skills_job_dim.job_id=skills_top_paying_jobs.job_id
INNER JOIN skills_dim ON 
skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL:** The most universally required skill, crucial for querying and managing structured data across industries.
- **Python:** Highly demanded for its flexibility in data analysis, automation, machine learning, and scripting workflows.
- **Tableau:** Widely used for creating interactive dashboards and effectively communicating data-driven insights.
- **Snowflake, Databricks, PySpark:** Gaining traction as essential tools for cloud-based data warehousing and big data processing.
- **Excel:** Still highly relevant for quick, ad-hoc analyses and widely used in business-focused data roles.

<img src="Assests\2.top paying skills.png" alt="Alt text" width="500"/>

*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated the code, and the bar graph was created using Google Colab.*

### 3.In-Demand Skills for Data Analysts
This analysis highlights the most in-demand skills across job postings, guiding focus toward high-value areas.
```sql 
SELECT skills,
    COUNT(skills_dim.skills) as demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    job_country='India'
GROUP BY
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- Core Competencies – SQL & Excel: These remain foundational, underscoring their critical role in data extraction, transformation, and day-to-day analysis.

- Technical & Analytical Tools – Python, Tableau, Power BI: Strong demand for these skills highlights the growing emphasis on automation, advanced analytics, and impactful data visualization.

- Evolving Skillset Needs: The blend of traditional and modern tools suggests that data analysts must balance operational efficiency with technical agility to stay competitive.

| Skill     | Demand Count |
|-----------|--------------|
| SQL       | 3167         |
| Python    | 2207         |
| Excel     | 2118         |
| Tableau   | 1673         |
| Power BI  | 1285         |

*Summary table of the leading 5 skills required in data analyst job postings.*

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying in India.

```sql 
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
   
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE 
    job_title_short='Data Analyst' AND job_location='India' AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY
   avg_salary DESC
LIMIT 15;
```


| Skill       | Average Salary (USD) |
|-------------|---------------------:|
| visio       |             119,250  |
| jira        |             119,250  |
| confluence  |             119,250  |
| power bi    |             118,140  |
| azure       |             118,140  |
| powerpoint  |             104,550  |
| flow        |              96,604  |
| sheets      |              93,600  |
| word        |              89,579  |
| sql         |              85,397  |
| excel       |              84,366  |
| pytorch     |              79,200  |
| unix        |              79,200  |
| tensorflow  |              79,200  |
| windows     |              79,200  |

Here's a breakdown of the results for top paying skills for Data Analysts in India:


- High-value collaboration and project management skills like Visio, Jira, and Confluence lead the salary pack (~$119K), highlighting the premium on efficient teamwork and workflow coordination in today’s workplaces.

- Business intelligence, cloud platforms, and automation tools such as Power BI, Azure, PowerPoint, and Microsoft Flow command strong salaries ($96K–$118K), reflecting the growing need for data visualization, cloud expertise, and process automation.

- Core data handling and emerging tech skills including SQL, Excel, PyTorch, TensorFlow, Unix, and Windows offer steady earning potential (~$79K–$89K), showing ongoing demand for foundational analytics, programming, and system administration capabilities.

### 5. Most Optimal Skills to Learn


This analysis of India’s job market shows which skills are in high demand and offer good salaries, helping professionals focus on learning the right skills to grow their careers.
 ```sql 
 SELECT
     skills_dim.skill_id, 
    skills_dim.skills,
    COUNT(skills_dim.skills) as demand_count,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    job_country='India'
GROUP BY
    skills_dim.skill_id
ORDER BY demand_count DESC,
    avg_salary DESC
LIMIT 10;
  ```
| Skill   | Demand Count | Average Salary (INR) |
|---------|--------------|---------------------|
| sql     | 3167         | 92,984              |
| python  | 2207         | 95,933              |
| excel   | 2118         | 88,519              |
| tableau | 1673         | 95,103              |
| power bi| 1285         | 109,832             |
| r       | 992          | 86,609              |
| azure   | 512          | 98,570              |
| sas     | 478          | 79,200              |
| aws     | 453          | 95,333              |

*Table of the most optimal skills for data analyst sorted by salary in India*

- **High-Demand Programming and Query Languages:**
SQL and Python lead with very high demand counts of 3,167 and 2,207 respectively. Their average salaries, around $92,984 for SQL and $95,933 for Python, show these skills are widely needed and well-compensated across industries.

- **Data Analysis and Visualization Tools:**
Excel and Tableau are highly popular, with demand counts of 2,118 and 1,673 and average salaries near $88,519 and $95,103. Power BI, though lower in demand (1,285), offers the highest average salary in this group at $109,832, highlighting the value of strong visualization skills.

- **Cloud Platforms:**
Azure and AWS show moderate demand (512 and 453) but provide good average salaries of about $98,570 and $95,333, reflecting the growing importance of cloud expertise in data and IT roles.

- **Specialized and Statistical Tools:**
R and SAS have lower demand counts (992 and 478) with average salaries around $86,609 and $79,200. These tools remain important for specific statistical and analytical tasks despite smaller market demand.
# What I learned
On this SQL journey, I’ve built a strong foundation and started exploring the powerful world of databases:

- 🗂️ Database Basics: I’ve grasped how databases are created and how data gets loaded into them, giving me a solid starting point to build on.

- 📥 Importing Data: Learned how to bring in existing tables from Excel files, making it easier to work with real-world data.
- ✍️ CRUD Fundamentals: I’m comfortable with the basics of inserting, updating, and deleting data, though I’m still getting familiar with all the nuances.
- ⚙️ Intermediate Manipulation: I’ve begun working with different SQL clauses and joining tables, experimenting with how to combine and analyze data effectively.
- 🐞 Debugging Practice: I’m getting better at identifying errors and troubleshooting my SQL code, improving my queries step by step.
- 💡 Developing Creativity: I’m starting to think creatively, crafting unique queries that go beyond the basics to uncover useful insights.

# Conclusions 
### Insights
From the analysis, several general insights emerged:

- **Top-Paying Data Analyst Roles:** Remote data analyst positions offer a broad salary range, with the highest reaching an impressive $650,000 annually.

- **SQL for High Salaries:** Top-paying data analyst roles often demand strong SQL skills, making it a key tool for unlocking higher earnings.
- **High-Demand Tech Stack:** SQL leads in demand for data analyst roles, while Python holds a strong second place—both are must-haves for aspiring analysts.
- ** Skills with Higher Salaries (India):** In the Indian market, specialized tools like Visio, Jira, and Confluence offer the highest average salaries (around ₹11.9 LPA), highlighting that niche business-oriented skills can lead to significantly better pay for data professionals.
- **High-Impact Skill:** SQL strikes the perfect balance between demand and salary, making it an ideal skill for data analysts who want to stand out in the job market.

### Closing Thoughts
This project has strengthened my SQL proficiency and provided valuable insights into the data analyst job market. The findings emphasize the importance of prioritizing high-demand, well-compensated skills to enhance career prospects. Continuous learning and adaptation to emerging trends remain essential for success in the field of data analytics.


