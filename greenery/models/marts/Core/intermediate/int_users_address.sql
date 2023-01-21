{{
    config(
        materialized ='view'
    )
}}

select 
users.USER_ID
, users.FIRST_NAME
, users.LAST_NAME
, users.EMAIL
, users.PHONE_NUMBER
, users.CREATED_AT
, users.UPDATED_AT
, users.ADDRESS_ID
, address.ADDRESS
, address.ZIPCODE
, address.STATE
, address.COUNTRY
from {{ ref('stg_users') }} as users
left join {{ ref('stg_addresses') }} as address on users.ADDRESS_ID = address.ADDRESS_ID