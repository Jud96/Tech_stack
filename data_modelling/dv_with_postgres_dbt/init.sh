#!/bin/bash
# install dbt-core
# pip install dbt-core
# install dbt-postgres adapter
pip install dbt-postgres
# create a new dbt project
dbt init dv_with_postgres_dbt
# after entering dbt init command, it will ask for the adapter, select postgresql
# enter the database name, username, password, host, port
# /home/xxxxx/.dbt/profiles.yml

# download the sample data
git clone https://github.com/electrum/tpch-dbgen.git
cd tpch-dbgen
# tune the makefile to generate the data for 1GB
sed -i 's/SCALE = 1/SCALE = 1/' makefile
# replace CC= with CC=gcc
sed -i 's/CC =/CC = gcc/' makefile
# replace DATABASE= with DATABASE=postgres
sed -i 's/DATABASE =/DATABASE = postgres/' makefile
# replace MACHINE= with MACHINE=LINUX
sed -i 's/MACHINE =/MACHINE = LINUX/' makefile
# replace WORKLOAD= with WORKLOAD=TPCH
sed -i 's/WORKLOAD =/WORKLOAD = TPCH/' makefile
make

cd data
cp ../dbgen .
cp ../dists.dss .

# Run dbgen for the appropriate database size factor (1GB in the sample). 
./dbgen -s 1

# clean data to remove the last | character
sed -i 's/|$//g' *.tbl

psql -h localhost -U postgres -d postgres -p 5432
# create database
create database tpch;
\q
# create tables in db.sql
psql -h localhost -U postgres -d tpch -p 5432 -f tpch_schema.sql

# load data into the tables in parallel
for i in `ls *.tbl`; do psql -h localhost -U postgres -d tpch -p 5432 -c "\copy ${i/.tbl/} from '${i}' with delimiter '|'" & done

# psql -h localhost -U postgres -d tpch <<EOF
# \copy customer FROM '$path/customer.tbl'  DELIMITER '|' NULL '' CSV;
# \copy orders FROM '$path/orders.tbl' DELIMITER '|' NULL '' CSV;
# \copy lineitem FROM '$path/lineitem.tbl' DELIMITER '|' NULL '' CSV;
# \copy nation FROM '$path/nation.tbl' DELIMITER '|' NULL '' CSV;
# \copy region FROM '$path/region.tbl' DELIMITER '|' NULL '' CSV;
# \copy part FROM '$path/part.tbl' DELIMITER '|' NULL '' CSV;
# \copy partsupp FROM '$path/partsupp.tbl' DELIMITER '|' NULL '' CSV;
# \copy supplier FROM '$path/supplier.tbl' DELIMITER '|' NULL '' CSV;
# EOF


#dbt deps # install dependencies
#dbt build # compile the project
#dbt run # run the project