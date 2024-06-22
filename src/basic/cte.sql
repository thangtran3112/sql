/*
  Find the count of the number of remote job postings per skill
   - Display the top 5 skills by their demand in remote jobs
   - Include skill Id, name, and count of job postings, which requires the skill
*/
WITH remote_job_skills AS (
  SELECT 
    skill_id,
    COUNT(*) AS skill_count
  FROM
    skills_job_dim AS skills_to_job
  INNER JOIN job_postings_fact AS job_postings
    ON job_postings.job_id = skills_to_job.job_id
  WHERE
    job_postings.job_work_from_home = true AND
    job_postings.job_title_short = 'Data Analyst'
  GROUP BY skill_id
)
SELECT 
  skills_dim.skill_id,
  skills_dim.skills,
  skill_count
FROM remote_job_skills
INNER JOIN skills_dim ON remote_job_skills.skill_id = skills_dim.skill_id