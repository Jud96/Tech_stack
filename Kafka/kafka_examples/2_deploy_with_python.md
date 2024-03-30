## kafka producer with topic partitioning

buffer_memory is the total bytes of memory the producer should use to buffer records waiting to be sent to the server. If records are sent faster than they can be delivered to the server the producer will block up to max_block_ms.

sending messages too fast using producer API

- when the producer calls send() , the messages will not be immediately sent but added to an internal buffer
- the default buffer size is 32MB
- if the producer sends messages faster than they can be transmitted to the broker or there is a network issue, it will exceeds buffer.memory then the send() method will block for max.block.ms (default 60s) and throw BufferExhaustedException if the buffer is full

```bash
# install kafka library
!pip install kafka-python
```

```bash 
cat basic_producer.py
```
producer.flush() is a blocking call and will wait for all previously sent messages to be delivered before returning. This is useful for ensuring message delivery, but it is also a performance bottleneck because it limits the number of messages that can be sent per second. To overcome this, we can use the asynchronous send method, which adds messages to a buffer immediately and returns without waiting for the broker to acknowledge receipt of the messages. This allows us to send messages at a much higher rate, but sacrifices reliability.

## Understanding Kafka partition assignment strategies with in-depth intuition 

```bash
# create a topic with 6 partitions
docker exec broker kafka-topics --create --bootstrap-server localhost:29092 --partitions 6 --replication-factor 1 --topic hello_world
```

```bash
cat partition_producer.py
```

```bash
python partition_producer.py
```

```bash
python partition_consumer.py
```

note:
- Schema Registry is a service that manages Avro schemas for Kafka. It allows the storage of a history of schemas which are versioned. It also allows for the evolution of schemas according to the configured compatibility settings and expanded Avro support.

**Avro** A data serialization and exchange framework that provides data structures, remote procedure call (RPC), compact binary data format, a container file, and uses JSON to represent schemas.

Avro schemas ensure that every field is properly described and documented for use with serializers and deserializers. You can either send a schema with every message or use Schema Registry to store and receive schemas for use by consumers and producers to save bandwith and storage space.