WITH raw_sales AS (
    SELECT * FROM {{ source('ecommerce', 'sales_ecomm')}}
)
SELECT 
	INVOICENO,
	STOCKCODE,
	DESCRIPTION,
	QUANTITY,
	INVOICEDATE,
	UNITPRICE,
	CUSTOMERID,
	COUNTRY
FROM 
    raw_sales