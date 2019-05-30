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
