{{
  config(
    materialized='view'
  )
}}

select
  vendors.vendor_name,
  count(orders.customer_id) as customer_counts,
  sum(gmv_local) as total_gmv
from `food-panda-bi-362115.Dataset.orders` as orders
left join `food-panda-bi-362115.Dataset.vendors` as vendors
       on orders.vendor_id = vendors.id
where orders.country_name = 'Taiwan'     
group by 1
order by customer_counts desc
