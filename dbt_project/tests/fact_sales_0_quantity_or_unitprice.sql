select * from {{ ref('fact_sales') }}
where unitprice = 0 or quantity = 0
limit 10