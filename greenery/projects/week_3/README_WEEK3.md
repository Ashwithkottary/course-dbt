# Week 3 Project Solutions:

## 1) What is our overall conversion rate?
```
    select 
        count(distinct case when order_id is not null then session_id end)                                  as unique_sessions_per_purchase
        , count(distinct session_id)                                                                        as total_unique_sessions
        , count(distinct case when order_id is not null then session_id end) / count(distinct session_id)   as Conversion_Rate
    from dev_db.dbt_ashwithkottaryaudibenede.stg_events;
```

 - 0.624567 or 62.45% conversion rate


## 2) What is our conversion rate by product?
```
    with event_order_item_data as (
        select 
            oi.product_id                                                                                   as product_id
            , count(distinct case when e.order_id is not null then session_id end)                          as unique_sessions_per_product_purchase
        from dev_db.dbt_ashwithkottaryaudibenede.stg_events e 
        left join dev_db.dbt_ashwithkottaryaudibenede.stg_order_items oi on oi.order_id = e.order_id
        where oi.product_id is not null
        group by 1
        order by 1
    )
    , event_data as (
        select 
        product_id
        , count(distinct case when event_type = 'page_view'  then session_id end)                           as unique_sessions_per_product_viewed
        from dev_db.dbt_ashwithkottaryaudibenede.stg_events
        where product_id is not null
        group by 1
        order by 1
    )
  
    select 
        coalesce(eoi.product_id, e.product_id) as product_id
        , p.name as product_name
        , unique_sessions_per_product_purchase
        , unique_sessions_per_product_viewed
        , unique_sessions_per_product_purchase / unique_sessions_per_product_viewed                         as conversion_rate_by_product
    from event_order_item_data eoi
    left join event_data as e on eoi.product_id = e.product_id
    left join dev_db.dbt_ashwithkottaryaudibenede.stg_products p on p.product_id = coalesce(eoi.product_id, e.product_id);
```

 - Output of the above query gives conversion rate on a product level

## 3) SNAPSHOTS: Which orders changed from week 2 to week 3?
```
   select 
   * 
   from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.ORDERS_SNAPSHOT 
   where order_id in (  select 
                            order_id 
                        from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.ORDERS_SNAPSHOT 
                        where dbt_valid_to :: date = '2023-01-27'
                     )
   order by order_id,  dbt_valid_from asc; 
```

- Following orders changed it's status from "preparing" to "shipped" between week 2 and week 3

  'e2729b7d-e313-4a6f-9444-f7f65ae8db9a'
  'c0873253-7827-4831-aa92-19c38372e58d' &
  '29d20dcd-d0c4-4bca-a52d-fc9363b5d7c6'