SELECT *
FROM job_postings_fact
LIMIT 10;

/* Convert/Casting Data Types */
SELECT 
  '2023-02-19'::DATE,
  '123'::INTEGER,
  'true'::BOOLEAN,
  '3.14'::REAL; 


SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date AS date_time
FROM job_postings_fact
LIMIT 5;

/* Extract Date from Timestamp */
SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date::DATE AS date
FROM job_postings_fact

/* Our dataset does not include timezone, we will convert it to UTC
* And then convert to EST
 */
SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact
LIMIT 5;

/* Extract Month from Timestamp */
SELECT 
  job_title_short AS title,
  job_location AS location,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
  EXTRACT(MONTH FROM job_posted_date) AS date_month,
  EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 5;

SELECT
  COUNT(job_id) as monthly_job,
  EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY monthly_job DESC;

/* After June 1, 2023*/
SELECT
  AVG(salary_year_avg) as yearly_avg,
  AVG(salary_hour_avg) as hourly_avg,
  job_schedule_type as schedule_type
FROM job_postings_fact
WHERE (job_posted_date::DATE > '2023-06-01') AND (NOT(salary_hour_avg IS NULL) OR NOT(salary_year_avg IS NULL)) 
GROUP BY job_schedule_type
ORDER BY yearly_avg DESC;

/* Convert date to America/New_York and count the job_id for each month in this timezone */
SELECT
  COUNT(job_id) as monthly_job,
  EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS est_month
FROM job_postings_fact
GROUP BY est_month
ORDER BY monthly_job DESC;


SELECT 
  COUNT(job_postings_fact.job_id),
  job_postings_fact.company_id,
  company_dim.name
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
  WHERE (job_health_insurance = TRUE) AND (EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC') >= 7)
  GROUP BY job_postings_fact.company_id, company_dim.name
  HAVING COUNT(job_postings_fact.job_id) > 0
  ORDER BY COUNT(job_postings_fact.job_id)



