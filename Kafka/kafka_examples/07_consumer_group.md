**consumer group** is a group of consumers which are interested in the same topic, and each consumer group maintains its own offset per topic partition.

why we need consumer group ? we need consumer group to **scale the consumption of messages from a topic**.

```python
## Start Zookeeper:
F:/kafka_2.12-3.2.0/bin/windows/zookeeper-server-start.bat F:/kafka_2.12-3.2.0/config/zookeeper.properties
## Start Kafka-server:
F:/kafka_2.12-3.2.0/bin/windows/kafka-server-start.bat F:/kafka_2.12-3.2.0/config/server.properties
## Create topic:
F:/kafka_2.12-3.2.0/bin/windows/kafka-topics.bat 
–create –topic hello_world1
 –bootstrap-server localhost:9092 
–replication-factor 1 
**–partitions 3**

```

```python
## Without Consumer Group:

F:/kafka_2.12-3.2.0/bin/windows/kafka-console-consumer.bat –topic hello_world1 –from-beginning –bootstrap-server localhost:9092

F:/kafka_2.12-3.2.0/bin/windows/kafka-console-consumer.bat –topic hello_world1 –from-beginning –bootstrap-server localhost:9092
```

## Start Consumer with Group:

```python
F:/kafka_2.12-3.2.0/bin/windows/kafka-console-consumer.bat –topic hello_world1 –from-beginning –bootstrap-server localhost:9092 **–group my-first-consumer-group**
```

## Producer Code:

```python
from time import sleep
from json import dumps
from kafka import KafkaProducer

topic_name='hello_world1'
producer = KafkaProducer(bootstrap_servers=['localhost:9092'],value_serializer=lambda x: dumps(x).encode('utf-8'))

while True:
    message=input("Enter the message you want to send : ")
    partition_no=int(input("In which partition you want to send ?  "))
    producer.send(topic_name, value=message,partition=partition_no)

producer.close()
```