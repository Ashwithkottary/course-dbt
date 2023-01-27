{% set event_types = get_distinct_column_values(
                                                column_name = 'event_type'
                                                , model_name = ref('stg_events') 
                                                ) %}
 
select 
     session_id
     , {% for event_type in event_types %}
      count( case when event_type = '{{event_type}}' then session_id  end  ) as {{event_type}}_session
     {% if not loop.last %} , {% endif %}
     {% endfor %}
from {{ ref('stg_events') }}
group by 1
