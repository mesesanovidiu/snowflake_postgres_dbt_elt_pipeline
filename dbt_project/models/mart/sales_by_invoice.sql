with fact_sales as (
    SELECT * FROM {{ ref('fact_sales') }}
)

SELECT DISTINCT 
    CUSTOMERID, 
    COUNTRY, 
    INVOICEDATE, 
    INVOICENO,
    sum(AMOUNT) as AMOUNT
FROM fact_sales
    GROUP BY INVOICENO, INVOICEDATE, CUSTOMERID, COUNTRY
