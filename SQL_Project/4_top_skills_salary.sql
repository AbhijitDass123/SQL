/* Top skills based on salaries for Data Analyst job*/


SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
   
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE 
    job_title_short='Data Analyst' AND job_location='India' AND salary_year_avg IS NOT NULL
GROUP BY skills, job_title_short,job_title
ORDER BY
   avg_salary DESC
LIMIT 15;
    

/*
RESULT

[
  {
    "skills": "excel",
    "avg_salary": "119250"
  },
  {
    "skills": "sql",
    "avg_salary": "119250"
  },
  {
    "skills": "jira",
    "avg_salary": "119250"
  },
  {
    "skills": "confluence",
    "avg_salary": "119250"
  },
  {
    "skills": "visio",
    "avg_salary": "119250"
  },
  {
    "skills": "sql",
    "avg_salary": "118140"
  },
  {
    "skills": "excel",
    "avg_salary": "118140"
  },
  {
    "skills": "power bi",
    "avg_salary": "118140"
  },
  {
    "skills": "flow",
    "avg_salary": "118140"
  },
  {
    "skills": "azure",
    "avg_salary": "118140"
  },
  {
    "skills": "excel",
    "avg_salary": "104550"
  },
  {
    "skills": "word",
    "avg_salary": "104550"
  },
  {
    "skills": "powerpoint",
    "avg_salary": "104550"
  },
  {
    "skills": "python",
    "avg_salary": "93600"
  },
  {
    "skills": "r",
    "avg_salary": "93600"
  },
  {
    "skills": "sql",
    "avg_salary": "93600"
  },
  {
    "skills": "sheets",
    "avg_salary": "93600"
  },
  {
    "skills": "tableau",
    "avg_salary": "89118"
  },
  {
    "skills": "excel",
    "avg_salary": "89118"
  },
  {
    "skills": "word",
    "avg_salary": "89118"
  },
  {
    "skills": "sql",
    "avg_salary": "89118"
  },
  {
    "skills": "python",
    "avg_salary": "89118"
  },
  {
    "skills": "unix",
    "avg_salary": "79200"
  },
  {
    "skills": "python",
    "avg_salary": "79200"
  },
  {
    "skills": "pytorch",
    "avg_salary": "79200"
  },
  {
    "skills": "sql",
    "avg_salary": "79200"
  },
  {
    "skills": "tableau",
    "avg_salary": "79200"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "79200"
  },
  {
    "skills": "windows",
    "avg_salary": "79200"
  },
  {
    "skills": "excel",
    "avg_salary": "75068"
  },
  {
    "skills": "flow",
    "avg_salary": "75068"
  },
  {
    "skills": "word",
    "avg_salary": "75068"
  },
  {
    "skills": "outlook",
    "avg_salary": "75068"
  },
  {
    "skills": "oracle",
    "avg_salary": "75068"
  },
  {
    "skills": "sql",
    "avg_salary": "75068"
  },
  {
    "skills": "r",
    "avg_salary": "71600"
  },
  {
    "skills": "python",
    "avg_salary": "71600"
  },
  {
    "skills": "excel",
    "avg_salary": "71600"
  },
  {
    "skills": "r",
    "avg_salary": "64800"
  },
  {
    "skills": "sql",
    "avg_salary": "64800"
  },
  {
    "skills": "sql",
    "avg_salary": "64800"
  },
  {
    "skills": "excel",
    "avg_salary": "64800"
  },
  {
    "skills": "python",
    "avg_salary": "64800"
  },
  {
    "skills": "python",
    "avg_salary": "64800"
  },
  {
    "skills": "sql server",
    "avg_salary": "64600"
  },
  {
    "skills": "ms access",
    "avg_salary": "64600"
  },
  {
    "skills": "t-sql",
    "avg_salary": "64600"
  },
  {
    "skills": "looker",
    "avg_salary": "64600"
  },
  {
    "skills": "vba",
    "avg_salary": "64600"
  },
  {
    "skills": "sql",
    "avg_salary": "64600"
  }
]
*/
