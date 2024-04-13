### Build your first model

go to the models folder and create a new file named `customers.sql` and copy and paste the following code:
```sql
with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers

),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final
```

```bash
dbt run
```

## Change the way your model is materialized

1- Edit your dbt_project.yml file. Change the materialization of the `customers` model to `table`:

```yaml
# dbt_project.yml
name: 'jaffle_shop'
models:
  jaffle_shop:
    +materialized: table
    example:
      +materialized: view
```

2- models/customers.sql to override the dbt_project.yml for the customers model only by adding the following snippet to the top.

```sql
{{
  config(
    materialized='view'
  )
}}
```

### Delete the example models
Delete the models/example/ directory.

Delete the example: key from your dbt_project.yml file, and any configurations that are listed under it.
```yaml
# after
models:
  jaffle_shop:
    +materialized: table
```