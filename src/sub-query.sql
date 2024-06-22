SELECT * FROM (
  SELECT * FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here

-- Common Table Expression (CTE) starts here
WITH january_jobs AS (
  SELECT * FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)-- CTE ends here
SELECT * FROM january_jobs;

SELECT 
  company_id,
  job_no_degree_mention
FROM
  job_postings_fact
WHERE
  job_no_degree_mention = true;

SELECT 
  company_id,
  name AS company_name
FROM company_dim
WHERE company_id IN (
  SELECT 
    company_id
  FROM
    job_postings_fact
  WHERE
    job_no_degree_mention = true
  ORDER BY company_id  
);

/* Finding the company with the most job openings */

WITH company_job_counts AS (
  SELECT
    count(*) as total_jobs,
    company_id
  FROM
    job_postings_fact
  GROUP BY
    company_id
  ORDER BY
    count(*) DESC
)
SELECT 
  company_dim.name AS company_name,
  company_job_counts.total_jobs
FROM 
  company_dim
LEFT JOIN company_job_counts ON company_dim.company_id = company_job_counts.company_id
ORDER BY
  company_job_counts.total_jobs DESC
LIMIT 1;