with fact_sales as (
    SELECT * FROM {{ ref('fact_sales') }}
)

SELECT
    STOCKCODE, 
    DESCRIPTION, 
    sum(QUANTITY) as QUANTITY,
    sum(AMOUNT)/sum(QUANTITY) as AVG_UNIT_PRICE,
    sum(AMOUNT) as AMOUNT
FROM fact_sales
    GROUP BY STOCKCODE, DESCRIPTION
