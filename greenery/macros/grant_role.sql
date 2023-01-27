{% macro grant_role(role) %}

{% set grant_query %}
GRANT USAGE ON SCHEMA {{ schema }} TO ROLE {{ role }};
GRANT SELECT ON {{ this }} to role {{ role }};
{% endset %}

{% set results = run_query(grant_query) %}

{% endmacro%}