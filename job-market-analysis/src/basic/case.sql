
/*Only January data*/
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1 AND NOT(salary_year_avg IS NULL);


/*Create table for January data only*/
CREATE TABLE IF NOT EXISTS january_jobs AS
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE IF NOT EXISTS february_jobs AS
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE IF NOT EXISTS march_jobs AS
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;

SELECT 
  job_title_short,
  job_location,
  CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
  END AS location_category
FROM job_postings_fact;


SELECT 
  Count(job_id) AS number_of_jobs,
  CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
  END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

SELECT 
  job_title_short,
  salary_year_avg,
  CASE
    WHEN salary_year_avg > 100000 THEN 'High'
    WHEN salary_year_avg > 50000 THEN 'Medium'
    ELSE 'Low'
  END AS salary_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;