{{
  config(
    materialized='view'
  )
}}

with gmv_per_country as (
select
  vendors.country_name,
  vendors.vendor_name,
  sum(gmv_local) as total_gmv,
  row_number() over(partition by vendors.country_name order by sum(gmv_local) desc) as row
from `food-panda-bi-362115.Dataset.vendors` as vendors
left join `food-panda-bi-362115.Dataset.orders` as orders
       on vendors.id = orders.vendor_id
where is_active = true
group by 1,2
)

select
  country_name,
  vendor_name,
  round(total_gmv,2) as total_gmv
from gmv_per_country
where row = 1
order by country_name
