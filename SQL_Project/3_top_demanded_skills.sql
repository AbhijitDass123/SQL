/* What are the most in-demand skills for Data Analyst Job in India?*/


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


/* 
RESULT

[
  {
    "skills": "sql",
    "demand_count": "3167"
  },
  {
    "skills": "python",
    "demand_count": "2207"
  },
  {
    "skills": "excel",
    "demand_count": "2118"
  },
  {
    "skills": "tableau",
    "demand_count": "1673"
  },
  {
    "skills": "power bi",
    "demand_count": "1285"
  }
]
*/