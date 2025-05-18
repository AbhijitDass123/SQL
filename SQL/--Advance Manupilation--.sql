--Advance Manupilation--

--CREATE NEW TABLE FROM EXISTING TABLE USING EXTRACT KEYWORD--
--JANUARY--
CREATE TABLE January_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date)=1


--FEBRUARY--
CREATE TABLE February_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--MARCH--
CREATE TABLE March_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT *
FROM February_job

SELECT *
FROM March_job
LIMIT 1000
---CASE EXPRESSION--
/* giving temporary name for the values
 to be understood easily and assign them in the new column*/

SELECT 
COUNT(job_id),
CASE
    WHEN job_title_short='Data Analyst' THEN 'DA'
    WHEN job_title_short='Data Scientist' THEN 'DS'
    WHEN job_title_short='Software Engineer' THEN 'SE'
    ELSE 'Random'
    END AS temp_job_title
FROM job_postings_fact
    WHERE search_location='India'
GROUP BY temp_job_title

SELECT *
FROM job_postings_fact
WHERE salary_year_avg>'130000'
LIMIT 1000



SELECT *from company_dim
limit 100;

SELECT *from job_postings_fact
limit 100;

SELECT *from skills_dim
limit 100;

SELECT *from skills_job_dim
limit 100;

SELECT 
job_title_short as Title,
job_location AS location,
job_posted_date AS Date
FROM 
job_postings_fact

--:: to change Data type--
/* in this the entier time stamp column is converted to DATE 
which will display only the Date*/
SELECT 
job_title_short as Title,
job_location AS location,
job_posted_date:: DATE AS Date
FROM 
job_postings_fact
limit 5;

--time zone--
SELECT 
job_title_short as Title,
job_location AS location,
job_posted_date  AT TIME ZONE 'IST'  Date
FROM 
job_postings_fact
limit 5;

--Extract Date/month/Year--
SELECT 
job_title_short as Title,
job_location AS location,
job_posted_date  AT TIME ZONE 'IST'  Date,
EXTRACT (MONTH FROM job_posted_date) AS Job_month,
EXTRACT (YEAR FROM job_posted_date) AS Job_years,
EXTRACT (DAY FROM job_posted_date) AS Job_Days
FROM 
job_postings_fact
limit 5;

--EXTRACT analysis--
SELECT
COUNT(job_id) as ID,
job_title,
EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM job_postings_fact
GROUP BY job_title,MONTH
ORDER BY ID desc
LIMIT 10000;

SELECT
COUNT(job_id) as ID,
job_title,
EXTRACT(MONTH FROM job_posted_date) AS MONTH
FROM job_postings_fact
WHERE job_title='Data Analyst'
GROUP BY job_title,MONTH
ORDER BY ID desc
LIMIT 10000;

--QUERY  1--
SELECT 
salary_year_avg,
salary_hour_avg,
job_schedule_type
FROM job_postings_fact
WHERE job_posted_date>'2023-6-1'
GROUP BY job_schedule_type,
salary_year_avg,
salary_hour_avg
order by salary_year_avg ASC

--QUERY 2--
SELECT
  EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS job_posting_month,
  COUNT(*) AS job_postings
FROM job_postings_fact
WHERE job_posted_date >= '2023-01-01' AND job_posted_date < '2024-01-01'
GROUP BY job_posting_month
ORDER BY job_posting_month;

--QUERY 3--
SELECT 
company.name,
Job.job_health_insurance,
EXTRACT(MONTH FROM Job.job_posted_date) AS month
FROM job_postings_fact AS Job
LEFT JOIN company_dim AS company
ON Job.company_id=company.company_id
WHERE Job.job_posted_date>='2023-04-01' AND Job.job_posted_date<='2023-06-01'
ORDER BY month desc



--QUERY--
SELECT
salary_year_avg,
job_title_short,
search_location,
    CASE 
    WHEN salary_year_avg>='100000'AND salary_year_avg<='150000' THEN 'HIGH'
    WHEN salary_year_avg>'1500000' AND salary_year_avg<='2000000' THEN 'STANDARD'
    WHEN salary_year_avg<'100000' then 'BPL'
    ELSE 'Exception'
    END AS salary_analysis
FROM job_postings_fact
WHERE job_title_short='Data Analyst'
ORDER BY salary_analysis desc

--SUBQUERY--
/*Simple query */

/*findinh jobs which has the 
greater salary than the average salary of the entier jobs*/

SELECT 
    salary_year_avg,  --outer query 
    job_title_short
from 
    job_postings_fact
WHERE 
    salary_year_avg>( --inner query 
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
    
)
  ORDER BY salary_year_avg;

--TYPES  1. SCALAR--
/*The subquery where the inner query returns onlu one row and one column*/

SELECT 
    salary_year_avg,  --outer query 
    job_title_short
from 
    job_postings_fact
WHERE 
    salary_year_avg>( --inner query 
    SELECT MIN(salary_year_avg)  --(This query returns single value i.e 1 row and 1 column)
    FROM job_postings_fact
    
)
  ORDER BY salary_year_avg

--using join--

SELECT *
FROM job_postings_fact AS jb
JOIN (
    SELECT AVG(salary_year_avg) AS avg_salary
    FROM job_postings_fact
) AS avg_sal
ON jb.salary_year_avg > avg_sal.avg_salary;

--Multiple row sub query
--SubQuery in which the inner query, Returns multiple rows with multiple columns
--Returns 1 columns with multiple rows

--Q job_country that has highest salary for each job_title_short

SELECT
    job_country,
    salary_year_avg,
    job_title_short
FROM 
    job_postings_fact AS high_salary_country

WHERE (salary_year_avg,job_title_short) IN(
SELECT 
    MAX(salary_year_avg) as highest_salary,
    job_title_short
FROM 
    job_postings_fact
GROUP BY 
    job_title_short) 

SELECT *
FROM
    job_postings_fact
    WHERE company_id='10'
    

SELECT *
FROM 
    company_dim

--Q Company names which Provides WFH--
SELECT *
FROM
    company_dim
WHERE name NOT IN(
    SELECT job_work_from_home
    FROM job_postings_fact
    WHERE job_work_from_home IS TRUE
)

--Correlated SubQuery
--In this the inner Query is dependant on the outer Query and cannot bhi Executed independantly

/*Find companies where salary_year_avg is NUL*/
SELECT name
FROM company_dim as company
WHERE  EXISTS(
    SELECT 1          --it checks whether the condition retrives the value or not it does not care about the actaul value
    FROM job_postings_fact As job
    WHERE company.company_id=job.company_id
    AND salary_year_avg IS null
)

--Nested Subquery, Query inside query inside query!! 
-- Outer query: select only job titles with avg salary above the global average

SELECT job_title_short, title_avg
FROM (
    -- Middle query: get job titles with their average salary
    SELECT job_title_short, AVG(salary_year_avg) AS title_avg
    FROM job_postings_fact
    GROUP BY job_title_short
) AS avg_sales
WHERE title_avg > (
    -- Inner query: just computes the overall average salary
    SELECT total_avg
    FROM (
        SELECT AVG(salary_year_avg) AS total_avg
        FROM job_postings_fact
    ) AS overall
);


--subquery using select clause/case function
SELECT salary_year_avg,
job_title_short,
(case when salary_year_avg>(SELECT 
    AVG(salary_year_avg) 
    FROM job_postings_fact)
    then 'Higher than the average'
    else 'lower'
    end)as remarks
    from job_postings_fact
    LIMIT 1000;


/*List the companies that never posted a 'Data Analyst' job.
(Use a subquery with NOT IN.)*/
SELECT company_id,
name AS company_name_WFH
FrOM company_dim
WHERE company_id NOT IN(
    SELECT company_id
    FROM 
    job_postings_fact
    WHERE job_work_from_home='TRUE'
)

SELECT *
FROM job_postings_fact
LIMIT 10

--CTE's Common Table Expressions--

/*Use of CTE within table*/
WITH Job_high_salary AS(
    SELECT 
    job_title_short,
    MAX(salary_year_avg)             /*This part of the code created a temp table(Job_high_salary) with expression which is not stored in the actual DB
                                        and can be used for the further use*/
    FROM job_postings_fact 
   GROUP BY  job_title_short
)
SELECT *
FROM Job_high_salary         /*With the help of the refrence table (Job_high_salary ) the query is been executed */
 
SELECT 
job_title_short,
count(*) AS total_job_postings
FROM job_postings_fact
GROUP BY job_title_short

--CTE By using JOINS--
WITH comapny_opening_counts AS(
SELECT 
    company_id ,
    COUNT(*) AS job_openings   /*this shows how many jobs are postd for each company*/
FROM job_postings_fact
    GROUP BY company_id
)
SELECT 
    name as Company_name,
    comapny_opening_counts .job_openings 
FROM company_dim
    LEFT JOIN comapny_opening_counts ON
    comapny_opening_counts.company_id =company_dim.company_id
    ORDER BY job_openings desc



