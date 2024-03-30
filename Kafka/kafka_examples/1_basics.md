
## definitions 
**zookeeper** is a distributed coordination service that is used to manage and coordinate large clusters of machines. It is used to provide a distributed configuration service, a distributed synchronization service, and a naming registry for large distributed systems. It is designed to be easy to program to and can be used in a wide range of distributed systems.

**kafka** is a distributed streaming platform that is used to build real-time data pipelines and streaming applications. It is designed to be scalable, fault-tolerant, and high-performance. It is used to collect, process, and store large volumes of data in real-time.

**schema registry** is a distributed storage service that is used to store and manage the schemas of data that is stored in kafka. It is used to ensure that the data that is stored in kafka is in the correct format and is compatible with the applications that are consuming the data.

**kafka connect** is a distributed data integration service that is used to connect kafka to external data sources and sinks. It is used to stream data from external sources into kafka and stream data from kafka into external sinks. It is designed to be scalable, fault-tolerant, and high-performance.

**ksqldb** is a distributed streaming SQL engine that is used to process and analyze data that is stored in kafka. It is used to run SQL queries on the data that is stored in kafka and to perform real-time data processing and analytics. It is designed to be scalable, fault-tolerant, and high-performance.

## build with docker compose
```bash 
cat docker-compose.yml
docker-compose up -d
```

## Basic commands

### create topic
```bash
# create new topic
docker exec broker kafka-topics --create --bootstrap-server localhost:29092 --partitions 1 --replication-factor 1 --topic Test1 
```

### list topics
```bash
# list topics
docker exec broker kafka-topics --list --bootstrap-server localhost:29092
```

### produce message
```bash
# produce messages
docker exec -i broker kafka-console-producer --broker-list localhost:29092 --topic Test1 
```

### consume message
```bash
# consume messages
docker exec broker kafka-console-consumer --bootstrap-server localhost:29092 --topic Test1 --from-beginning
```
```bash
#reading messages from a specific partition and offset
docker exec broker kafka-console-consumer --bootstrap-server localhost:29092 --topic Test1 --partition 0 --offset 0
```

note: you can't read from a specific offset if  you haven't chosen a specific partition
```bash
#reading messages from a specific partition and offset
docker exec broker kafka-console-consumer --bootstrap-server localhost:29092 --topic Test1 --offset 0 # error
```

<aside>
📌 1)Topics are particular stream of data in Kafka
 2)You can have as many topics as you want 
3)A topic is identified by it’s name
 4)Topics are split in partitions
 5)Each partition is ordered
 6)Each message within a partition gets an incremental id , called offset 
7)Offset only have a meaning for a specific partition 
8)Order is guaranteed within a partition (not across partitions)
 9)Data is kept only for a limited time (default is one week) 
10)Once the data is written to a partition , it can’t be changed (immutability) 
11)Data is assigned randomly to a partition unless a key is provided
12) if you increase the number of partitions, you can't decrease it and the cost of the operation is high
</aside>



