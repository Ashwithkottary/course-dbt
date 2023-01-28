{% macro get_distinct_column_values(column_name, model_name) %}

{# set the query name as 'distinct query' #}
{% set distinct_query %}
select distinct 
{{ column_name }}
from {{ model_name }}
{% endset %}

{#store the output of the query in a variable called results#}
{% set results = run_query(distinct_query) %}

{% if execute %}
{#return the first column values#}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{#return the unique values of the first column as a list#}
{{ return(results_list) }}

{% endmacro %}