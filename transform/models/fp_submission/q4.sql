{{
  config(
    materialized='view'
  )
}}


with gmv as (
select
  date_trunc(date_local, YEAR) as year,
  orders.country_name,
  vendors.vendor_name,
  round(sum(orders.gmv_local),2) as total_gmv
from `food-panda-bi-362115.Dataset.orders` as orders
left join `food-panda-bi-362115.Dataset.vendors` as vendors
       on orders.vendor_id = vendors.id
group by 1,2,3
),

rank as (
select
  *,
  rank() over(partition by year, country_name order by gmv.total_gmv desc) as ranking
from gmv
)

select
  year,
  country_name,
  vendor_name,
  total_gmv
from rank
where ranking <=2
order by year,country_name
