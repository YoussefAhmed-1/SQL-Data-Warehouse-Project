-- --**************  load table: erp_cust_az12 ***************
INSERT INTO silver.erp_cust_az12
(
    cid,
    bdate,
    gen
)
SELECT 
--Handling the cid
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
     ELSE cid
     END cid_new,
-- handling bdate
CASE WHEN bdate > GETDATE() THEN NULL
     ELSE  bdate
END AS bdate,
--normailze the gen column
CASE WHEN UPPER(TRIM(gen)) IN ( 'F','FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ( 'M','MALE') THEN 'Male'
     ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12
