## Rack awareness in Kafka
Rack awareness is a feature in Kafka that allows you to distribute replicas across racks in a data center. This is useful for fault tolerance, as it ensures that replicas are not all in the same rack.
benifits of rack awareness:
- **Fault tolerance**: If a rack goes down, the replicas on that rack will be lost, but the replicas on other racks will still be available.
- **Load balancing**: By distributing replicas across racks, you can balance the load on the racks and avoid overloading any one rack.
- **Network bandwidth**: By distributing replicas across racks, you can reduce the amount of network traffic between racks, which can improve performance.

### Configuration
```bash
## Start Kafka-server with multi brokers

F:/kafka_2.12-3.3.1/bin/windows/kafka-server-start.bat F:/kafka_2.12-3.3.1/config/server.properties

F:/kafka_2.12-3.3.1/bin/windows/kafka-server-start.bat F:/kafka_2.12-3.3.1/config/server1.properties

F:/kafka_2.12-3.3.1/bin/windows/kafka-server-start.bat F:/kafka_2.12-3.3.1/config/server2.properties

F:/kafka_2.12-3.3.1/bin/windows/zookeeper-shell.bat localhost:2181 ls /brokers/ids

# Create a topic with 1 partition and replica 2 
F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –create –topic demo_testing2 –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –replication-factor 2 –partitions 1

# describe topic
F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –describe –topic demo_testing2

# set broker.rack=1 for broker 0 & 1 and broker.rack=2 for broker 2

# Create a topic with 1 partition and replica 2 
F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –create –topic demo_testing3 –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –replication-factor 2 –partitions 1
#describe topic
F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –describe –topic demo_testing3

#repeat process
F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –create –topic demo_testing4 –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –replication-factor 2 –partitions 1

F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –describe –topic demo_testing4

# repeat process again 
F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –create –topic demo_testing5 –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –replication-factor 2 –partitions 1

F:/kafka_2.12-3.3.1/bin/windows/kafka-topics.bat –bootstrap-server localhost:9092,localhost:9093,localhost:9094 –describe –topic demo_testing5
```
we create replica 1 in rack 1 and replica 2 in rack 2