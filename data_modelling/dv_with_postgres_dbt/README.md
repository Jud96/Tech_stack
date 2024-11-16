


```bash
# connect to postgres
psql -h localhost -U postgres -d postgres -p 5432
# create database
create database tpch;
\q
# create tables in db.sql
psql -h localhost -U postgres -d tpch -p 5432 -f db.sql
# clean data with sed
sed -i 's/|$//g' *.tbl

# extract data to postgres
path='/home/majid/work/Tech_stack/data_modelling/dv_with_postgres_dbt/tpch-dbgen/data'
# without header to public schema
for i in `ls $path/*.tbl`; do echo $i; psql -h localhost -U postgres -d tpch -p 5432 -c "\copy public.${i##*/} from '$i' with delimiter '|'  CSV;"; done

psql -h localhost -U postgres -d tpch -c "\copy customer FROM '$path/customer.tbl' (FORMAT 'text', DELIMITER '|');"


```

sed -i 's/|$//g' partsupp.tbl
psql -h localhost -U postgres -d tpch <<EOF
\copy partsupp FROM '$path/partsupp.tbl' DELIMITER '|' NULL '' CSV;
EOF

```bash
dbt deps # install dependencies
dbt build # compile the project
dbt run # run the project
```

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- download data [in the docs](https://docs.deistercloud.com/content/Databases.30/TPCH%20Benchmark.90/Data%20generation%20tool.30.xml?embedded=true)

- https://docs.verdictdb.org/documentation/step_by_step_tutorial/tpch_load_data/