Create Table job_details112 (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(200)
);

INSERT INTO  job_details112(job_id ,
    application_sent_date ,
    custom_resume ,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name ,
    status 

)
VALUES (1,'2024-02-01',true,'resume_01.pdf',true,'cover_letter_01.pdf','submitted'),
(2, '2024-02-05', true, 'resume_02.pdf', true, 'cover_letter_02.pdf', 'submitted'),
(3, '2024-02-10', false, 'resume_03.pdf', false, 'cover_letter_03.pdf', 'draft'),
(4, '2024-02-15', true, 'resume_04.pdf', false, 'cover_letter_04.pdf', 'submitted'),
(5, '2024-02-20', true, 'resume_05.pdf', true, 'cover_letter_05.pdf', 'pending'),
(6, '2025-04-15', true, 'resume_job6_custom.pdf', true, 'cover_letter_job6.pdf','submitted')
;
SELECT  *
FROM job_details112
ORDER BY  job_id asc;

--ALTER TABLE--
/* use to make changes in the structure of the table
 and not into its actual Data present in it*/ 
ALTER TABLE job_details112
Add contact  VARCHAR(200);

--UPDATE TABLE--
/*Used to manupilate the actuall data of the table */

UPDATE job_details112
SET contact = 'Herlin'
WHERE job_id = 1;

UPDATE job_details112
SET contact = 'Aarav'
WHERE job_id = 2;

UPDATE job_details112
SET contact = 'Sanya'
WHERE job_id = 3;

UPDATE job_details112
SET contact = 'Ritika'
WHERE job_id = 4;

UPDATE job_details112
SET contact = 'Yash'
WHERE job_id = 5;


--RENAME COLUMN--
/*Renames the column name with the help of ALTER method which activates that changes is to be made in the table...
without it,directly changes cannot be made into the columns or any other data*/

ALTER TABLE job_details112
RENAME  contact TO contact_name112
SELECT *
FROM job_details112

--DATATYPE CHANGE--
/* It is not possible for all datatypes to be changed in any other datatype...
ex= Integer to Text or vice verse*/
ALTER TABLE job_details112
ALTER Column contact_name112 TYPE TEXT

--DROP --
/* use to delete column OR Table permanently*/
ALTER TABLE job_details112
DROP COLUMN contact_name112

DROP TABLE job_details11
DROP TABLE job_aaplied

--Delete Row--
DELETE from job_details112
WHERE job_id=6

--UNION
-- combines the results from 2 or more select statements
--It should have same number of columns and Data type should be matched 

SELECT job_title_short,
company_id,
job_location
FROM January_job

UNION 

SELECT job_title_short,
company_id,
job_location
FROM February_job

/*Job from 1st quater with salary of greater than 70k*/

SELECT quarter_table.job_title_short,
    quarter_table.job_location
    
 FROM
    (SELECT *
FROM January_job

UNION ALL

SELECT  
    *
FROM February_job

UNION ALL

SELECT 
    *
FROM march_job) AS quarter_table
WHERE quarter_table.salary_year_avg>'80000'