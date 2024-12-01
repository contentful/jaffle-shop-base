with customer_data as (

    select
        customer_id,
        customer_name
    from {{ ref('stg_customers') }}
),

orders as (

    select
        customer_id,
        count(distinct order_id) as total_order_count,
        sum(order_total) as total_order_amount
    from {{ ref('stg_orders') }}
    group by 1
)

select
    customer_data.customer_id,
    customer_name,
    total_order_count,
    total_order_amount,
    case when total_order_count > 5 and total_order_amount > 100 then true else false end is_top_customer
from customer_data
left join orders on customer_data.customer_id = orders.customer_id
