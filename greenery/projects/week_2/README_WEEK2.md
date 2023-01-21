# Week 2 Project Solutions:

## 1) What is our user repeat rate?
```
    with base as (
        select user_id as users
        , count(distinct order_id) as no_of_orders
    from  stg_orders
    group by 1
    )
    select 
        count(case when no_of_orders >= 2 then users end) / count(users) as repeat_rate
    from base ;
```

 - 0.798387 or 79.8% Repeat rate


## 2) Why did you organize the models in the way you did?

- dim_users : created this dimension model by combining stg_users & stg_addresses as i believe  address data is related to the users and combining them makes sense. This table will have granualrity on a user level. Besides user info, this table also provides information if there multiple users from the same household.

Performed the joins as an intermediate model and dim table is just a simple select from the intermidate model

- fact_user_orders: created this fact model to represent measures such as total_orders, first_order_date, last_order_date, overall_order_cost, overall_shipping_cost & total_cost from a user perspective. This table would be useful to perform analyses on user behaviour. 

Performed the joins as an intermediate model and fact table is just a simple select from the intermidate model

- fact_product_measures: created this fact model to represent measures such as total_page_views, total_add_to_carts, total_sessions,  & total_orders from a product perspective. This table would be useful to perform analyses on trending products and to understand user preference on product level 

Performed the joins as an intermediate model and fact table is just a simple select from the intermidate model


## 3) What assumptions are you making about each model? (i.e. why are you adding each test?) & Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

- I have not found any bad/inaccurate data in the models. 

- You can find all the tests in "_core_model.yml", "_marketing_model.yml" & "_product_model.yml" file in the repo


## 4) SNAPSHOTS: Which orders changed from week 1 to week 2?
```
   select 
   * 
   from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.ORDERS_SNAPSHOT 
   where order_id in (  select 
                            order_id 
                        from DEV_DB.DBT_ASHWITHKOTTARYAUDIBENEDE.ORDERS_SNAPSHOT 
                        where dbt_valid_to is not null
                     )
   order by order_id,  dbt_valid_from asc; 
```

- Following orders changed it's status from "preparing" to "shipped" 
  '265f9aae-561a-4232-a78a-7052466e46b7',
  'b4eec587-6bca-4b2a-b3d3-ef2db72c4a4f'  &
  'e42ba9a9-986a-4f00-8dd2-5cf8462c74ea'