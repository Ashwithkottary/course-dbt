{# This macro outputs a simple 'select from table' sql statement with the possibility to exclude  upto 10 columns #} 
{# By default, column arguments (col_name_1 to col_name_10) are set to an empty string #} 
{# This is done so that you can specify only the number of column arguements that need to be excluded and need not worry about specifying the remaining arguements #}
{% macro exclude_columns_on_select( schema_name , table_name , col_name_1 ='', col_name_2 ='', col_name_3 ='', col_name_4 ='', col_name_5 =''
                                  , col_name_6 = '', col_name_7 = '', col_name_8 = '', col_name_9 = '', col_name_10 = '') %}

{#set the query name as 'column_name_query'#}
{% set column_name_query%}
{#following query spits out only columns that need to be included in the select statement#}
SELECT 
COLUMN_NAME
FROM {{ target.database }}.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = '{{ table_name }}' 
  AND TABLE_SCHEMA = '{{ schema_name }}' {# in this case 'schema_name' would be our personal schema. ex: schema_name = 'DBT_ASHWITHKOTTARYAUDIBENEDE' #}
  AND COLUMN_NAME not in  ('{{ col_name_1 }}','{{ col_name_2 }}','{{ col_name_3 }}','{{ col_name_4 }}','{{ col_name_5 }}'
                            ,'{{ col_name_6 }}','{{ col_name_7 }}','{{ col_name_8 }}','{{ col_name_9 }}','{{ col_name_10 }}')
ORDER BY COLUMN_NAME ASC

{% endset %}

{# store the output of the query in a variable called results #}
{%set results = run_query(column_name_query) %}

    {% if execute %}
    {# return the first column values #}
    {%set results_list = results.columns[0].values() %}

    {% else %}
    {%set results_list = [] %}
    
    {% endif %}

{# following select statement will be the output of the macro #}
select
    {# loop through the column/s that need to be included #}
    {% for col in results_list %}
    {{col}} as {{col}}  {# selecting the column/s and aliasing it/them  #}
    {% if not loop.last %} , {% endif %} {# this is done to avoid trailing comma at the last run of the loop. If its the last run, then avoid placing a comma #}
    {% endfor %}
from {{ target.database }}.{{ schema_name }}.{{ table_name }}

    {% endmacro %}