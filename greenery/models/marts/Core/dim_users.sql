select 
USER_ID         -- as "User ID"
, FIRST_NAME    -- as "First Name"
, LAST_NAME     -- as "Last Name"
, EMAIL         -- as "Email"
, PHONE_NUMBER  -- as "Phone"
, CREATED_AT    -- as "Created At"
, UPDATED_AT    -- as "Updated At"
, ADDRESS_ID    -- as "Address ID"
, ADDRESS       -- as "Address"
, ZIPCODE       -- as "Zipcode"
, STATE         -- as "State"
, COUNTRY       -- as "Country"
from {{ ref('int_users_address') }}