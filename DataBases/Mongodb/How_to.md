





## HOW TO

### from CLI
**run it in docker**

```bash
docker run -d -p 27017:27017 -v ~/data:/data/db --name mongodb mongo
```

**connect to it**

```bash
docker exec -it mongodb bash
mongosh
```

**create a database**

```bash
use mydatabase
```
**create a collection**

```bash
db.createCollection('mycollection')
```

**insert a document**

```bash
db.mycollection.insertOne({name: 'John Doe', age: 30, status: 'A', groups: ['news', 'sports']})
db.mycollection.insertOne({name: 'Jane Doe', age: 25, status: 'B', groups: ['news', 'other']})
db.mycollection.insertOne({name: 'Jim Doe', age: 40, status: 'A', groups: ['news', 'arts']})
db.mycollection.insertOne({name: 'Jill Doe', age: 35, status: 'B', groups: ['news', 'games']})
```
**find a document**

```bash
db.mycollection.find()
```
**find a document with a filter**

```bash
db.mycollection.find({status: 'A'})
```
**complex filter**

```bash
db.mycollection.find({status: 'A', age: {$gt: 30}})
db.mycollection.find({status: 'A', age: {$lt: 30}})
db.mycollection.find({$and: [{status: 'A'}, {age: {$gt: 30}}]})
db.mycollection.find({$or: [{status: 'A'}, {age: {$gt: 30}}]})

```

**find a document with a filter and projection**

```bash
db.mycollection.find({status: 'A'}, {name: 1, age: 1})
```

**update a document**

```bash
db.mycollection.updateOne({name: 'John Doe'}, {$set: {age: 31}})
```

**delete a document**

```bash
db.mycollection.deleteOne({name: 'John Doe'})
```

**delete a collection**

```bash
db.mycollection.drop()
```

**delete a database**

```bash
db.dropDatabase()
```

**sort a collection**

```bash
db.mycollection.find().sort({age: 1})
db.mycollection.find().sort({age: -1})
```

**limit a collection**

```bash
db.mycollection.find().limit(2)
```

**skip a collection**

```bash
db.mycollection.find().skip(2)
```

**create an index**

```bash
db.mycollection.createIndex({name: 1})
```

**list indexes**

```bash
db.mycollection.getIndexes()
```

**drop an index**

```bash
db.mycollection.dropIndex('name_1')
```

**aggregate**

```bash
db.mycollection.aggregate([
    {$match: {status: 'A'}},
    {$group: {_id: '$status', total: {$sum: 1}}}
])
```

**export a collection**

```bash
mongoexport --db mydatabase --collection mycollection --out mycollection.json
```


### from python

**connect to it**

```python
import pymongo

client = pymongo.MongoClient('mongodb://localhost:27017/')
db = client['mydatabase']
collection = db['mycollection']
```

**insert a document**

```python
collection.insert_one({'name': 'John Doe', 'age': 30, 'status': 'A', 'groups': ['news', 'sports']})
collection.insert_one({'name': 'Jane Doe', 'age': 25, 'status': 'B', 'groups': ['news', 'other']})
collection.insert_one({'name': 'Jim Doe', 'age': 40, 'status': 'A', 'groups': ['news', 'arts']})
collection.insert_one({'name': 'Jill Doe', 'age': 35, 'status': 'B', 'groups': ['news', 'games']})
```

**find a document**

```python
for doc in collection.find():
    print(doc)
```

**find a document with a filter**

```python
for doc in collection.find({'status': 'A'}):
    print(doc)
```

**complex filter**

```python
for doc in collection.find({'status': 'A', 'age': {'$gt': 30}}):
    print(doc)
for doc in collection.find({'status': 'A', 'age': {'$lt': 30}}):
    print(doc)
for doc in collection.find({'$and': [{'status': 'A'}, {'age': {'$gt': 30}}]}):
    print(doc)
for doc in collection.find({'$or': [{'status': 'A'}, {'age': {'$gt': 30}}]}):
    print(doc)
```

**find a document with a filter and projection**

```python
for doc in collection.find({'status': 'A'}, {'name': 1, 'age': 1}):
    print(doc)
```

**update a document**

```python
collection.update_one({'name': 'John Doe'}, {'$set': {'age': 31}})
```

**delete a document**

```python
collection.delete_one({'name': 'John Doe'})
```

**delete a collection**

```python
collection.drop()
```

**delete a database**

```python
client.drop_database('mydatabase')
```

**sort a collection**

```python
for doc in collection.find().sort('age', 1):
    print(doc)
for doc in collection.find().sort('age', -1):
    print(doc)
```

**limit a collection**

```python
for doc in collection.find().limit(2):
    print(doc)
```

**skip a collection**

```python
for doc in collection.find().skip(2):
    print(doc)
```

**create an index**

```python
collection.create_index('name')
```

**list indexes**

```python
print(collection.index_information())
```

**drop an index**

```python
collection.drop_index('name_1')
```

**aggregate**

```python
pipeline = [
    {'$match': {'status': 'A'}},
    {'$group': {'_id': '$status', 'total': {'$sum': 1}}}
]
for doc in collection.aggregate(pipeline):
    print(doc)
```

**export a collection**

```python
import subprocess

subprocess.run(['mongoexport', '--db', 'mydatabase', '--collection', 'mycollection', '--out', 'mycollection.json'])
```