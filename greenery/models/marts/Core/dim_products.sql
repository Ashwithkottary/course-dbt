select 
PRODUCT_ID                          --as "Product ID"
, NAME            as product_name   --as "Product Name"
, PRICE                             --as "Price"
, INVENTORY                         --as "Inventory"
from {{ ref('stg_products') }}