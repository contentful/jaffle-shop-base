select product_id, count(distinct order_id) as count_orders
from {{ref('order_items')}}
group by product_id