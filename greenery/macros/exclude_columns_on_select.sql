{% macro exclude_columns_on_select( schema_name , table_name , col_name_1 ='', col_name_2 ='', col_name_3 ='', col_name_4 ='', col_name_5 =''
    , col_name_6 = '', col_name_7 = '', col_name_8 = '', col_name_9 = '', col_name_10 = ''     ) %}

{% set column_name_query%}
SELECT 
COLUMN_NAME
FROM {{ target.database }}.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = '{{ table_name }}' and TABLE_SCHEMA = '{{ schema_name }}'
  AND COLUMN_NAME not in  ('{{ col_name_1 }}','{{ col_name_2 }}','{{ col_name_3 }}','{{ col_name_4 }}','{{ col_name_5 }}'
                            ,'{{ col_name_6 }}','{{ col_name_7 }}','{{ col_name_8 }}','{{ col_name_9 }}','{{ col_name_10 }}')
ORDER BY COLUMN_NAME ASC

{% endset %}

{%set results = run_query(column_name_query) %}

    {% if execute %}
    {%set results_list = results.columns[0].values() %}

    {% else %}
    {%set results_list = [] %}
    
    {% endif %}

select
    {% for col in results_list %}
    {{col}} as {{col}} {% if not loop.last %} , {% endif %}
    {% endfor %}
from {{ target.database }}.{{ schema_name }}.{{ table_name }}

    {% endmacro %}