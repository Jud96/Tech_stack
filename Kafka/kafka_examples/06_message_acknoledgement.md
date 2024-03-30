## message acknoledgement

### round robin fashion & acknledgement theory
<aside>
📌 to enable sending full key value pairs from command line we need to use two properties 
 1- parse.key : default is false, if it is true then message key is mandatory 
 2- key.separtor

</aside>

<aside>
📌 the **acks parameter** controls how many partition replicas must receive the record before the producer can consider the write successful. the option has a significant impact on the consistency guarantees of the producer

**acks = 0** the producer will not wait for a reply from the broker before assuming the message was sent successfully. This means that if something goes wrong and the broker does not receive the message, the producer will not know about it and the message will be lost.

**acks =1** the producer will receive a successful response from the broker the moment the leader replica received the message. If the message can’t be written to the leader, the producer will receive an error response and can retry sending the message ,avoiding data loss.

**acks =all** the producer will receive success response from the broker only when all the in sync replicas received the message. This ensures that the message will not be lost as long as at least one in sync replica remains alive. This is the strongest available guarantee. This is equivalent to the acks=-1 setting. adding latency and safety

</aside>

```bash
#Start Producer
 F:/kafka_2.12-3.2.0/bin/windows/kafka-console-producer.bat 
	–topic hello_world2
	–bootstrap-server localhost:9092
# Now to send the messages and key-value pair , we are going to launch producer using this command
F:/kafka_2.12-3.2.0/bin/windows/kafka-console-producer.bat 
–bootstrap-server localhost:9092 
**–property "parse.key=true" 
–property "key.separator=:"**
–topic hello_world2
#Publish the messages 
#1001:“Mobile,100” 1002:“Mouse,50” 1001:“Computer,1500” 1003:“Pen,2” 1002:“Earphone,65” 1001:“Notebook,99”
```

```bash
## Start Consumer:

F:/kafka_2.12-3.2.0/bin/windows/kafka-console-consumer.bat –topic hello_world2 –from-beginning –bootstrap-server localhost:9092
```

### sendMessageMethods

there are three methods to send messages to kafka

- fire and forget
    
    is the simplest method that send a message to kafka and don't care about the result , some messages may be lost
    
    ```python
    from time import sleep
    from json import dumps
    from kafka import KafkaProducer
    
    topic_name='hello_world1'
    producer = KafkaProducer(bootstrap_servers=['localhost:9092'],
    					value_serializer=lambda x: dumps(x).encode('utf-8'))
    
    for e in range(100):
        data = {'number' : e}
        print(data)
        producer.send(topic_name, value=data)
        sleep(0.5)
    ```
    
- synchronous method
    
     that send a message to kafka and wait for the result , if the result is not successful it will raise an exception
    
    ```python
    from time import sleep
    from json import dumps
    from kafka import KafkaProducer
    
    topic_name='hello_world1'
    producer = KafkaProducer(bootstrap_servers=['localhost:9092'],value_serializer=lambda x: dumps(x).encode('utf-8'))
    
    for e in range(100):
        data = {'number' : e}
        print(data)
        try:
            record_metadata =producer.send(topic_name, value=data).get(timeout=10)
            print(record_metadata.topic)
            print(record_metadata.partition)
            print(record_metadata.offset)
            sleep(0.5)
        except Exception as e:
            print(e)
    
    producer.flush()
    producer.close()
    ```
    
- asynchronous method
    
     that send a message to kafka and wait for the result , if the result is not successful it will raise an exception
    
    ```python
    from time import sleep
    from json import dumps
    from kafka import KafkaProducer
    
    topic_name='hello_world1'
    producer = KafkaProducer(bootstrap_servers=['localhost:9092'],value_serializer=lambda x: dumps(x).encode('utf-8'))
    
    def on_send_success(record_metadata,message):
        print("""Successfully produced "{}" to topic {} and partition {} at offset {}""".format(message,record_metadata.topic,record_metadata.partition,record_metadata.offset))
        print()
    
    def on_send_error(excp,message):
        print('Failed to write the message "{}" , error : {}'.format(message,excp))
    
    for e in range(100):
        data = {'number' : e}
        record_metadata =producer.send(topic_name, value=data)
       .add_callback(on_send_success,message=data).add_errback(on_send_error,message=data)
        print("Sent the message {} using send method".format(data))
        print()
        sleep(0.5)
    
    producer.flush()
    producer.close()
    ```
    

<aside>
📌 * suppose the network roundtrip time between our app and Kafka cluster is 10ms 
* if we wait for a reply after sending each message, sending 100 messages will take 1 second
* on the other hand if we send all messages without waiting for a reply, sending 100 messages will barely take any time
* in most cases we really don't care about the result of sending a message to kafka
* on the other hand we do need to know when we failed to send a message to kafka

**asynchronus method is the best method to send messages to kafka**

</aside>