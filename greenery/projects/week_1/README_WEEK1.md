# Week 1 Project Solutions:

## 1) How many users do we have?
```
    select 
        count(*) as total_users 
    from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.STG_USERS;
```

 - 130 users.


## 2) On average, how many orders do we receive per hour?
```
    with orders_per_hour as(
        select 
            date_trunc(hour,created_at) as hours
            , count(order_id)           as orders_unique
        from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.STG_ORDERS
        group by 1
    )
    select 
        round(avg(orders_unique),2) 
    from orders_per_hour;
```

- Average of 7.52 orders per hour.


## 3) On average, how long does an order take from being placed to being delivered?
```
    select 
        round(sum(datediff(DAYS, created_at, delivered_at)) / count(case when status = 'delivered' then order_id end),2) as average_delivery_time
    from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.STG_ORDERS
    where status = 'delivered';
```

- Average of 3.89 or ~4 days for an order to being delivered.


## 4) How many users have only made one purchase? Two purchases? Three+ purchases?
```
    with unique_purchases as (
        select 
        user_id as users
        , count( distinct order_id )    as orders
    from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.STG_ORDERS
    group by 1
    )
    select
        case when orders = 1 then '1 Purchase'
            when orders = 2 then '2 Purchases'
            when orders > 2 then '3 or more Purchases'
        end                             as no_of_purchases
        , count(users)
    from unique_purchases
    group by 1
    order by 1;
```

-  25 users made 1 purchase, 28 users made 2 purchases and 71 users made 3 or more puchases.


## 5) On average, how many unique sessions do we have per hour?
```
    with session_per_hours as (
        select 
            date_trunc(hour, created_at) as session_ts
            , count(distinct session_id) as sessions_unique
        from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.STG_EVENTS
        group by 1
    )
    select 
        round(avg(sessions_unique),2)
    from session_per_hours;   
```

- Average of 16.33 sessions per hour.