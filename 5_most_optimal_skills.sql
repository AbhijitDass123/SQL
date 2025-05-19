/* What is the most optimal skills in terms of high paying salary and in demand*/

WITH demand_skills AS (
    SELECT
        skills_dim.skill_id, 
        skills_dim.skills,
        COUNT(skills_dim.skills) as demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        job_country='India'
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) as avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE 
        job_title_short='Data Analyst' AND 
        job_country='India' AND 
        salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id
    
)
SELECT
    demand_skills.skills,
    demand_count,
    avg_salary
FROM
    demand_skills
INNER JOIN average_salary ON demand_skills.skill_id = average_salary.skill_id
ORDER BY demand_count DESC,
        avg_salary DESC
LIMIT 25;





--Rewrite the same query more concisely
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
LIMIT 25;
