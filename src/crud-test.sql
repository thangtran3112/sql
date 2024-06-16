DROP TABLE IF EXISTS job_applied;

CREATE TABLE IF NOT EXISTS job_applied (
  job_id INT,
  application_sent_date DATE,
  custom_resume BOOLEAN,
  resume_file_name VARCHAR(255),
  cover_letter_sent BOOLEAN,
  cover_letter_file_name VARCHAR(255),
  status VARCHAR(50)
);

INSERT INTO job_applied
  (job_id, application_sent_date, custom_resume, resume_file_name, cover_letter_sent, cover_letter_file_name, status)
VALUES
  (1, '2024-02-01', true, 'resume_01.pdf', true, 'cover_letter_01.pdf', 'submitted'),
  (2, '2024-02-02', false, 'resume_02.pdf', true, 'cover_letter_02.pdf', 'submitted'),
  (3, '2024-02-03', true, 'resume_03.pdf', true, 'cover_letter_03.pdf', 'submitted'),
  (4, '2024-02-04', true, 'resume_04.pdf', false, 'cover_letter_04.pdf', 'submitted'),
  (5, '2024-02-05', true, 'resume_05.pdf', true, 'cover_letter_05.pdf', 'submitted'),
  (6, '2024-02-06', false, 'resume_06.pdf', true, 'cover_letter_06.pdf', 'submitted'),
  (7, '2024-02-07', true, 'resume_07.pdf', true, 'cover_letter_07.pdf', 'submitted'),
  (8, '2024-02-08', true, 'resume_08.pdf', false, 'cover_letter_08.pdf', 'submitted');

ALTER TABLE job_applied
  ADD contact VARCHAR(50);

SELECT * FROM job_applied;

UPDATE job_applied
SET contact = 'John Doe'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Jane Doe'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Jack Doe'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Emily Tran'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Sarah Tran'
WHERE job_id = 5;

UPDATE job_applied  
SET contact = 'Michael Tran'
WHERE job_id = 6;

UPDATE job_applied
SET contact = 'Thang Tran'
WHERE job_id = 7;

UPDATE job_applied
SET contact = 'Tram Nguyen'
WHERE job_id = 8;

ALTER TABLE job_applied
  RENAME COLUMN contact TO contact_name;

ALTER TABLE job_applied
  ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
  DROP COLUMN contact_name;

SELECT * FROM job_applied;
