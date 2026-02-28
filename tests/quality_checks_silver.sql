/*
=========================================================
Quality checks
==========================================================
Script Purpose:
This script performs various quality checks for data consistency, accuracy and standardization across the 'silver' schemas. It includes checks for:
- Nulls or duplicate primary keys.
- Unwanted spaces in string fields.
- Data Standardization & consistency.
- Invalid date ranges & orders.
- Data consistency between related fields.

Usage Notes:
- Run these checks after data loading Silver layer.
- Investigate and resolve any discrepancies found during the checks.
====================================================================
*/
---Checking data quality for bronze.crm_prd_info---

---Check for nulls or Duplicates in Primary Key---
--Expectation: No Result--
SELECT prd_id, COUNT(*) FROM bronze.crm_prd_info
GROUP BY prd_id
Having COUNT(*)>1 OR prd_id IS NULL
--Checking the category id in erp tables--
SELECT 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key, 1,5), '-', '_')AS cat_id,
prd_nm, 
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
FROM bronze.crm_prd_info
WHERE REPLACE(SUBSTRING(prd_key, 1,5), '-', '_') NOT IN (SELECT DISTINCT id FROM bronze.erp_px_cat_g1v2);

---Checking the prd_key in sls_prd_key---
SELECT 
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key, 1,5), '-', '_')AS cat_id,
SUBSTRING(prd_key, 7, len(prd_key)) AS prd_key,
prd_nm, 
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
FROM bronze.crm_prd_info
WHERE SUBSTRING(prd_key, 7, len(prd_key)) NOT IN (SELECT DISTINCT id FROM bronze.erp_px_cat_g1v2);

--Check for unwanted Spaces--
SELECT prd_nm FROM bronze.crm_prd_info
WHERE prd_nm!= TRIM(prd_nm);

--Check for nulls or negative numbers in prd_cost--
--Expectations: No result--
SELECT prd_cost FROM bronze.crm_prd_info
WHERE prd_cost<0 OR prd_cost IS NULL;

---Data Standarization & Consistency---
SELECT DISTINCT prd_line FROM bronze.crm_prd_info;

---Check for invalid end_dates and start_dates--
SELECT * FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

---Data checking for erp._cust_az12---
SELECT cid, bdate, gen FROM bronze.erp_cust_az12
WHERE cid LIKE '%AW00011000%';
SELECT * FROM silver.crm_cust_info
WHERE cst_key LIKE '%AW00011000%';
--Identify out of range dates--
SELECT DISTINCT bdate FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate> GETDATE()
--Data Standardisation & Consistency--
SELECT DISTINCT gen  FROM bronze.erp_cust_az12

---Checking data of erp_loc_a101---
SELECT REPLACE(cid,'-', '')cid,
cntry 
FROM bronze.erp_loc_a101
WHERE REPLACE (cid,'-','') NOT IN (SELECT cst_key FROM silver.crm_cust_info);

--Data Standardisation & Consistency--
SELECT DISTINCT(cntry) FROM bronze.erp_loc_a101

---Checking the data in bronze layer for transformations of table erp_px_cat_g1v2---
SELECT id, cat, subcat, maintenance FROM bronze.erp_px_cat_g1v2
--Check for unwanted soaces--
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat!= TRIM(cat) OR subcat!=TRIM(subcat) OR maintenance!= TRIM(maintenance)
--Check for Data Standardisation & Consistency--
SELECT DISTINCT cat FROM bronze.erp_px_cat_g1v2
SELECT DISTINCT subcat FROM bronze.erp_px_cat_g1v2
SELECT DISTINCT maintenance FROM bronze.erp_px_cat_g1v2

---Checking for spaces in the sls_ord_num column---
SELECT sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_ord_num!= sls_ord_num;

----Checking the sls_prd_key with the crm_prd_info to see whether we can use it during joining---
SELECT sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);


----Checking the sls_cust_id with the crm_cust_info to see whether we can use it during joining---
SELECT sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);

---Check for invalid dates(sls_order_dt)---
SELECT sls_ord_num,
sls_prd_key,
sls_cust_id,
NULLIF(sls_order_dt, 0)sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_order_dt<=0 OR LEN(sls_order_dt)!=8
---Check for invalid dates(sls_ship_dt)---
SELECT sls_ord_num,
sls_prd_key,
sls_cust_id,
NULLIF(sls_order_dt, 0)sls_order_dt,
NULLIF(sls_ship_dt,0) sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_ship_dt<=0 OR LEN(sls_ship_dt)!=8
---Check for invalid dates(sls_due_dt)---
SELECT sls_ord_num,
sls_prd_key,
sls_cust_id,
NULLIF(sls_order_dt, 0)sls_order_dt,
NULLIF(sls_ship_dt,0) sls_ship_dt,
NULLIF(sls_due_dt,0) sls_due_dt,
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_due_dt<=0 OR LEN(sls_due_dt)!=8

---Check for invalid Date Orders---
SELECT * FROM bronze.crm_sales_details
WHERE sls_order_dt>sls_ship_dt OR sls_order_dt>sls_due_dt
---Check data consistency: Between sales, quantity, and price---
-->>Sales = Quantity* Price
-->>Values must not be null, negative or zero---
SELECT sls_sales,
sls_quantity,
sls_price FROM bronze.crm_sales_details
WHERE sls_sales!=sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0
ORDER BY sls_sales, sls_quantity, sls_price;
---Check for nulls or Duplicates in Primary Key---
--Expectation: No Result--
SELECT cst_id, COUNT(*) FROM bronze.crm_cust_info
GROUP BY cst_id
Having COUNT(*)>1 OR cst_id IS NULL;

---Check for unwanted spaces---
---Expectation: No Result---
SELECT cst_firstname FROM bronze.crm_cust_info
WHERE cst_firstname!= TRIM(cst_firstname);

---Check for unwanted spaces---
---Expectation: No Result---
SELECT cst_lastname FROM bronze.crm_cust_info
WHERE cst_lastname!= TRIM(cst_lastname);

---Data Standarization & Consistency---
SELECT DISTINCT cst_marital_status FROM bronze.crm_cust_info

---Data Standarization & Consistency---
SELECT DISTINCT cst_gndr FROM bronze.crm_cust_info


 
