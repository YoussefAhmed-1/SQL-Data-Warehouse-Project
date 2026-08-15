--======================== Prepre The Data For Silver Layer =====================================
--------- ********************** crm_cust_info ********************** ---------
-- ================ check for null or duplicate in primary key ================================
SELECT * FROM bronze.crm_cust_info
WHERE cst_id IS NULL ;


SELECT  cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 ;

-- Understand the issue
SELECT * FROM bronze.crm_cust_info
WHERE cst_id = 29466;

SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
			FROM bronze.crm_cust_info;

--SLOVE THE ISSUE
SELECT * 
	FROM (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
			FROM bronze.crm_cust_info
			WHERE cst_id IS NOT Null)t
	WHERE flag_last = 1 ;
--==========================================================================================
--=========================== Checek for Unwanted Spaces ===================================
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

SELECT cst_marital_status
FROM bronze.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status);

--the are unwanted spaces in  fristname , last name  cloumns
-- Slove the unwanted spaces 
SELECT cst_id,
	   cst_key,
	   TRIM(cst_firstname) AS cst_firstname,
	   TRIM(cst_lastname) AS cst_lastname,
	   cst_gndr,
	   cst_marital_status,
	   cst_create_date

FROM (
		SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
		FROM bronze.crm_cust_info
		WHERE cst_id IS NOT Null)t
WHERE flag_last = 1 ;
		
--==============================================================================
--================= Data Standardization & Consistency =========================
-- *********** Gender Column ***********

SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info;


SELECT cst_id,
	   cst_key,
	   TRIM(cst_firstname) AS cst_firstname,
	   TRIM(cst_lastname) AS cst_lastname,
	   CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			ELSE 'n/a'
		END cst_gndr,
	   cst_marital_status,
	   cst_create_date

FROM (
		SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
		FROM bronze.crm_cust_info
		WHERE cst_id IS NOT Null)t
WHERE flag_last = 1 ;
		
--------------------------------------------------------------------------------------------
-- *********** Marital Status ***********
SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info;

SELECT cst_id,
	   cst_key,
	   TRIM(cst_firstname) AS cst_firstname,
	   TRIM(cst_lastname) AS cst_lastname,
	   CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			ELSE 'n/a'
	   END cst_gndr,
	   CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			ELSE 'n/a'
	   END cst_marital_status,
	   cst_create_date

FROM (
		SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
		FROM bronze.crm_cust_info
		WHERE cst_id IS NOT Null)t
WHERE flag_last = 1 ;
		
--------## Now Insert the data in Silver layer after cleaning
