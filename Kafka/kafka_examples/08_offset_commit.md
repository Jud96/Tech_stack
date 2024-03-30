## offset_commit

### Kafka Consumer using Python & Concept of Offset-Commit

let’s say we have a topic with four partitions and a consumer group with four consumers consuming the messages from the topic using polling mechanism.

**offset commit** is the process of updating the current offset of a consumer group in a topic-partition to the broker.

the decision onwhether to consumee from the beginning of a topic partition or to only consume new messages when there is no initial offset for the consumer group is controlled by the **auto.offset.reset** configuration parameter on kafka consumer side.

earliest: automatically reset the offset to the earliest offset latest: automatically reset the offset to the latest offset (default)

## Producer Code:

```python
from time import sleep
from json import dumps
from kafka import KafkaProducer

topic_name='hello_world4'
producer = KafkaProducer(bootstrap_servers=['localhost:9092'],value_serializer=lambda x: dumps(x).encode('utf-8'))

for e in range(1000):
    data = {'number' : e}
    print(data)
    producer.send(topic_name, value=data)
    sleep(2)
```

## Consumer Code:

```python
from kafka import KafkaConsumer
import json

consumer = KafkaConsumer ('hello_world4',bootstrap_servers = ['localhost:9092'],
value_deserializer=lambda m: json.loads(m.decode('utf-8')),
group_id='demo112215sgtrjwrykvjh',auto_offset_reset='earliest')

for message in consumer:
    print(message)
```

### Manual Offset Commits & Exactly-Once Once Processing in Kafka Consumer using Python

<aside>
📌 When we spin up a consumer and the consumer has subscribed to a topic which already has some messages in diff partitions then the consumptions of messages will not be in order in newly spinned up consumer as the single consumer is consuming messages from more than one partition and message ordering not guaranteed across multiple partitions– same phenomenon we observed in this demo also…

Also note , kafka is maintaining offset in partition level for a topic as different consumers are consuming messages from different partitions , so committed offsets for diff consumers will not be same , so it is not possible to have a single offset in topic level. As a result when consumer rebalancing happens , then for any partition , the new consumer start consuming the messages where earlier consumer stopped & ensure no messages are missed.

</aside>

## Producer Code used:

```python
from time import sleep
from json import dumps
from kafka import KafkaProducer

topic_name='hello_world1'
producer = KafkaProducer(bootstrap_servers=['localhost:9092'],value_serializer=lambda x: dumps(x).encode('utf-8'))

for e in range(1000):
    data = {'number' : e}
    print(data)
    producer.send(topic_name, value=data)
    sleep(2)
```

## Consumer Code:

```python
from kafka import KafkaConsumer
from kafka import TopicPartition , OffsetAndMetadata

import json

consumer = KafkaConsumer ('hello_world1',bootstrap_servers = ['localhost:9092'],
value_deserializer=lambda m: json.loads(m.decode('utf-8')),group_id='demo112215sgtrjwrykvjh',auto_offset_reset='earliest',enable_auto_commit =False)

for message in consumer:
    print(message)
    print("The value is : {}".format(message.value))
    print("The key is : {}".format(message.key))
    print("The topic is : {}".format(message.topic))
    print("The partition is : {}".format(message.partition))
    print("The offset is : {}".format(message.offset))
    print("The timestamp is : {}".format(message.timestamp))
    **tp=TopicPartition(message.topic,message.partition)
    om = OffsetAndMetadata(message.offset+1, message.timestamp)
    consumer.commit({tp:om})**
    print('*' * 100)
```

- Apache Kafka Consumer Lag Analysis in-depth intuition
    
    consumer lag is the difference between how fast the consumer is consuming messages from the broker and how fast the broker is producing messages. If the consumer is consuming messages faster than the broker is producing them, the consumer lag will be negative. If the broker is producing messages faster than the consumer is consuming them, the consumer lag will be positive.
    
    there's bound to be some lag from the consumer ,but ideally the consumer will catch up, or at least have a consistent lag rather than a gradually increasing one.
    
    ```bash
    #To get the information about Consumer Lag:
    
    F:/kafka_2.12-3.3.1/bin/windows/kafka-consumer-groups.bat
     --bootstrap-server localhost:9092
     --group demo112215sgtrjwrykvjh --describe
    ```