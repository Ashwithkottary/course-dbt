{{
    config(
        materialized = 'view'
    )
}}

SELECT 
EVENT_ID
, SESSION_ID
, USER_ID
, EVENT_TYPE
, PAGE_URL
, CREATED_AT
, ORDER_ID
, PRODUCT_ID
FROM {{source('postgres','events')}}