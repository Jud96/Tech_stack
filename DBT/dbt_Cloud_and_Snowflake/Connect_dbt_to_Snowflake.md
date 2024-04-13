## connect dbt Cloud to Snowflake

### configuration:

```bash
pip install dbt-core dbt-snowflake
```

```bash
dbt init dbt_snowflake
cd dbt_snowflake
```

```yaml
# dbt_snowflake/profiles.yml
dbt_snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <account_name>
#  ✅ db5261993 or db5261993.east-us-2.azure
#   ❌ db5261993.eu-central-1.snowflakecomputing.com
      user: dbt_user
      password: dbt_password
      role: Accountadmin
      database: dbt
      warehouse: compute_wh
      schema: dbt
      threads: 4
      client_session_keep_alive: False
      query_tag: dbt
```