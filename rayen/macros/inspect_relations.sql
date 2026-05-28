{% macro inspect_relations(schema_name) %}
    {% set sql %}
        select
            table_schema,
            table_name,
            column_name,
            data_type
        from information_schema.columns
        where table_schema = '{{ schema_name }}'
        order by table_schema, table_name, ordinal_position
    {% endset %}

    {% set results = run_query(sql) %}

    {% if execute %}
        {% for row in results.rows %}
            {{ log(row[0] ~ '.' ~ row[1] ~ '.' ~ row[2] ~ ' : ' ~ row[3], info=true) }}
        {% endfor %}
    {% endif %}
{% endmacro %}
