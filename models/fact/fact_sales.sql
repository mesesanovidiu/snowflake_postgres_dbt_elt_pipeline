with source_sales as (
    SELECT * FROM {{ ref('source_sales') }}
)

    SELECT 
        INVOICENO,
	    STOCKCODE,
	    DESCRIPTION,
        QUANTITY,
        INVOICEDATE,
        UNITPRICE,
        CUSTOMERID,
        COUNTRY,
        UNITPRICE*QUANTITY AS AMOUNT
    FROM source_sales
