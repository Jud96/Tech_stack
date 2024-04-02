Apache Hive:

Apache Hive is a distributed, fault-tolerant data warehouse system that enables analytics of large datasets residing in distributed storage using SQL.

Name node:
Name node is the master server that manages the file system namespace and regulates access to files by clients.

Data node:
Data node is the slave server that stores the actual data in HDFS.

Hive Metastore:
Hive Metastore is a database that stores metadata for Hive tables and partitions.

configuration files:

```bash
#mkdir Hive
#cd Hive
touch docker-compose.yml
touch hadoop-hive.env
mkdir employee
cd employee
touch employee_table.hql
touch employee.csv
```

Create & Start all services
```bash
docker-compose up -d
docker stats
```

### Demo

```bash
#Log onto the Hive-server
docker exec -it hive-server /bin/bash
```

```bash
ls
#hadoop-2.7.4  hiver
cd ..
ls
#bin  boot  dev employee  entrypoint.sh  etc  hadoop-data  home  lib  lib64  media  mnt  opt  #proc  root  run  sbin  srv  sys  tmp  usr  var
cd employee/
```
Execute the employee_table.hql to create a new external hive table employee under a new database testdb.

```bash
hive -f employee_table.hql
```
let’s add some data to this hive table. For that, simply push the employee.csv present in the employee directory on the hive-server into HDFS.

```bash
hadoop fs -put employee.csv hdfs://namenode:8020/user/hive/warehouse/testdb.db/employee
```

## Validate the setup
    
```bash
hive
```
```sql
show databases;
--OK
--default
--testdbTime taken: 2.363 seconds, Fetched: 2 row(s)
use testdb;
--OKTime taken: 0.085 seconds
select * from employee;
```
