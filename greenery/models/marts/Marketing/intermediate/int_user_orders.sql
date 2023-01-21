{{
    config ( 
        materialized = 'view'
    )
}}


select 
u.user_id
,array_agg(order_id) as order_ids
,count(distinct order_id) as total_orders
, min(o.created_at) as first_order_date
, max(o.created_at) as last_order_date
, sum(o.order_cost) as overall_order_cost
, sum(o.shipping_cost) as overall_shipping_cost
, sum(o.order_total) as total_cost
from {{ ref('stg_users') }} u
left join {{ ref('stg_orders') }} o on o.USER_ID = u.USER_ID
group by 1