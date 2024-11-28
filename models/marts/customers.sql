with customer_data AS (

    select customer_id
            , customer_name
    from {{ref('stg_customers')}}
)

, orders AS (
    
    select customer_id
            , count(distinct order_id) as total_order_count
            , sum(order_total) as total_order_amount
    from {{ref('stg_orders')}}
    group by 1
)

select customer_data.customer_id
        , customer_name
        , total_order_count
        , total_order_amount
from customer_data
left join orders on customer_data.customer_id = orders.customer_id