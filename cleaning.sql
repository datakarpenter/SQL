-- Checking duplicates by 2 factors
SELECT *
FROM tbl AS base

INNER JOIN (
 SELECT 
 var1
 , var2
FROM TBL
GROUP BY var1, var2
HAVING COUNT(*) > 1) dupes
ON base.var1 = dupes.var1
 AND base.var2 = dupes.var2
                     
-- Checking duplicates via Postgres UUID
SELECT * 
FROM tbl a 
USING (
 SELECT MIN(ctid) as ctid
 , var1
 FROM tbl 
 GROUP BY var1 HAVING COUNT(*) > 1
 ) b
WHERE a.var1 = b.var1 
 AND a.ctid <> b.ctid

-- Check tabs
SELECT *
FROM tbl 
WHERE (RTRIM(var1) LIKE '%' + CHAR(9) +  '%')

-- Removing non-alphabetical characters
SELECT regexp_replace(var1, '[^[:alpha:]]', ' ', 'g’)
FROM tbl

-- Upserting files without UPSERT
DELETE FROM tbl 
  USING staging_tbl 
  WHERE tbl.ID = staging_tbl.ID; 

INSERT INTO tbl 
SELECT * 
FROM staging_tbl; 

DELETE FROM staging_tbl

                      
-- Replace value with string
UPDATE tbl
SET var1 = REPLACE(var1, '123\', '')
