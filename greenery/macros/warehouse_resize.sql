{% macro warehouse_resize(prod_size, dev_size)%}

{% if target.name == 'prod' %}
ALTER WAREHOUSE {{ target.warehouse }} SET WAREHOUSE_SIZE = {{ prod_size }};

{% else %}
ALTER WAREHOUSE {{ target.warehouse }} SET WAREHOUSE_SIZE = {{dev_size}};

{% endif %}

{% endmacro %}