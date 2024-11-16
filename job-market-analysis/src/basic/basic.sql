SELECT 
	job_title_short,
    job_location
FROM job_postings_fact
LIMIT 5;

SELECT
	job_title_short,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE
	job_title_short = 'Data Analyst'
ORDER BY
	salary_year_avg DESC;

SELECT
	job_title_short,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE NOT
	job_title_short = 'Data Analyst'
    AND
    salary_year_avg > 50000
ORDER BY
	salary_year_avg ASC
SELECT
	job_title_short,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE 
	job_title_short = 'Data Analyst'
    OR 
    salary_year_avg BETWEEN 60000 AND 90000
ORDER BY
	salary_year_avg DESC
    
 SELECT 
 	job_title_short,
	job_location,
    job_via,
    salary_year_avg
FROM job_postings_fact
WHERE
	job_location IN ('Boston, MA', 'Anywhere') AND
    (
      	(job_title_short = 'Data Analyst' AND salary_year_avg > 100000) OR
    	(job_title_short = 'Business Analyst' AND salary_year_avg > 70000)
    );
SELECT 
	job_id
 	job_title_short,
	job_title,
    job_location,
    salary_year_avg
FROM job_postings_fact   
WHERE job_title LIKE '%Analyst'

-- Represent a single space with _
SELECT 
	job_id AS id,
 	job_title_short AS short_title,
	job_title AS full_title,
    job_location as location,
    salary_year_avg as salary
FROM job_postings_fact   
WHERE full_title LIKE '%Business_Analyst%';

SELECT 
	job_id AS id,
 	job_title_short AS short_title,
	job_title AS full_title,
    job_location as location,
    salary_year_avg as salary
FROM job_postings_fact   
WHERE 
	(job_title LIKE '%Data%' OR job_title LIKE '%Business%') AND
    job_title LIKE '%Analyst%' AND
    job_title NOT LIKE '%Senior%'
ORDER BY
	salary DESC;

	
SELECT
	SUM(salary_year_avg) AS salary_sum,
    COUNT(*) AS count_rows
FROM
	job_postings_fact

SELECT
    COUNT(DISTINCT job_title_short) AS job_type_total
FROM
	job_postings_fact


SELECT
	job_title_short AS jobs,
	AVG(salary_year_avg) as salary_avg,
    MIN(salary_year_avg) as salary_min,
    MAX(salary_year_avg) as salary_max
FROM 
	job_postings_fact 
WHERE 
	job_title_short = 'Data Analyst'

SELECT
	job_title_short AS jobs,
    COUNT(job_title_short) AS jobs_count,
	AVG(salary_year_avg) as salary_avg,
    MIN(salary_year_avg) as salary_min,
    MAX(salary_year_avg) as salary_max
FROM 
	job_postings_fact
GROUP BY
	job_title_short
HAVING
	COUNT(job_title_short) > 100
ORDER BY
	salary_avg 


SELECT 
    job_title_short,
	job_location,
    job_via,
    salary_year_avg 
FROM 
	job_postings_fact
WHERE
	salary_year_avg IS NOT NULL
ORDER BY
	salary_year_avg

	
SELECT 
	job_postings.job_id,
    job_postings.job_title_short, 
    companies.company_id,
    companies.name	
FROM 
	job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
	ON job_postings.company_id = companies.company_id 


SELECT 
	job_postings.job_id,
    job_postings.job_title_short, 
    companies.company_id,
    companies.name	
FROM 
	job_postings_fact AS job_postings
RIGHT JOIN company_dim AS companies
	ON job_postings.company_id = companies.company_idjob_postings_fact
    
SELECT 
	job_postings.job_id,
    job_postings.job_title,
    skills_to_job_table.skill_id,
    skills_table.skills
FROM 
	job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job_table ON job_postings.job_id = skills_to_job_table.job_id
INNER JOIN skills_dim AS skills_table ON skills_to_job_table.skill_id = skills_table.skill_id


SELECT 
	job_postings.job_id,
    job_postings.job_title,
    skills_to_job_table.skill_id,
    skills_table.skills,
    COUNT(*) AS skill_count
FROM 
	job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job_table ON job_postings.job_id = skills_to_job_table.job_id
INNER JOIN skills_dim AS skills_table ON skills_to_job_table.skill_id = skills_table.skill_id
WHERE
	(job_postings.job_title LIKE '%Data%') OR (job_postings.job_title LIKE '%Analyst%')
GROUP BY
	job_postings.job_id
HAVING
	skill_count > 4 -- Job with more than 4 skills
ORDER BY
	skill_count DESC 
    

SELECT
	skills_table.skills AS skill_name, -- Group these calculation by skill name
    COUNT(skills_to_job_table.job_id) AS number_of_job_postings, -- number of job postings per skills
    AVG(job_postings.salary_year_avg) AS average_salary_for_skill -- average salary per skills
FROM 
	skills_dim AS skills_table
LEFT JOIN skills_job_dim AS skills_to_job_table ON skills_table.skill_id = skills_to_job_table.skill_id
LEFT JOIN job_postings_fact AS job_postings ON skills_to_job_table.job_id = job_postings.job_id
GROUP BY
	skills_table.skills
ORDER BY
	average_salary_for_skill DESC