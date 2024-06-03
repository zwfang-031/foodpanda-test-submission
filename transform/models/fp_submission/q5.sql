select 
  q3.country_name,
  q2.vendor_name,
  q3.total_gmv
from {{ref('q2')}} as q2
left join {{ref('q3')}} as q3
       on q2.vendor_name = q3.vendor_name
