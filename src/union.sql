SELECT  
  job_title_short,
  company_id,
  job_location
FROM
  january_jobs
UNION
SELECT  
  job_title_short,
  company_id,
  job_location
FROM
  february_jobs;

SELECT  
  job_title_short,
  company_id,
  job_location
FROM
  january_jobs
UNION ALL
SELECT  
  job_title_short,
  company_id,
  job_location
FROM
  february_jobs
UNION ALL
SELECT  
  job_title_short,
  company_id,
  job_location
FROM
  march_jobs;

/**
* Get all first quarter jobs and their skill names and types
* with salary > 70000
*/
WITH q1_job_skillIds AS (
  WITH first_quarter_jobs AS (
    SELECT job_id, job_title, salary_year_avg, job_posted_date FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1 AND salary_year_avg > 70000
    UNION ALL
    SELECT job_id, job_title, salary_year_avg, job_posted_date FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2 AND salary_year_avg > 70000
    UNION ALL
    SELECT job_id, job_title, salary_year_avg, job_posted_date FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3 AND salary_year_avg > 70000
)-- CTE ends here
SELECT 
  first_quarter_jobs.job_id, 
  first_quarter_jobs.job_title,
  skills_job_dim.skill_id, 
  salary_year_avg,
  job_posted_date
FROM first_quarter_jobs
LEFT JOIN skills_job_dim ON first_quarter_jobs.job_id = skills_job_dim.job_id
)
SELECT q1_job_skillIds.job_id, 
  q1_job_skillIds.job_title,
  salary_year_avg, 
  job_posted_date::DATE,
  q1_job_skillIds.skill_id,
  skills_dim.skills,
  skills_dim.type  
FROM q1_job_skillIds
LEFT JOIN skills_dim ON q1_job_skillIds.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

