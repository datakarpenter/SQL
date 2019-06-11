-- Find records present or not present in two tables
SELECT * 
FROM tbl 
WHERE exists
  -- WHERE not exists
(select * from staging_tbl where tbl.ID = staging_tbl.ID)
