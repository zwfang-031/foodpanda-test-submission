{{
  config(
    materialized='view'
  )
}}

SELECT
  country_name,
  round(sum(gmv_local),2) AS total_gmv
FROM `food-panda-bi-362115.Dataset.orders` 
GROUP BY country_name

