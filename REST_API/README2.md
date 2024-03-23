## Python REST APIs With Flask, Connexion, and SQLAlchemy

**Add New Dependencies**
    
```bash
python -m pip install "flask-marshmallow[sqlalchemy]==0.14.0"
```

```bash
#Install the pinned dependencies from `requirements.txt`:
python -m pip install -r requirements.txt
```

**Build Your Database**

```bash
import sqlite3
conn = sqlite3.connect("people.db")
columns = [
     "id INTEGER PRIMARY KEY",
    "lname VARCHAR UNIQUE",
   "fname VARCHAR",
    "timestamp DATETIME",
 ]
create_table_cmd = f"CREATE TABLE person ({','.join(columns)})"
conn.execute(create_table_cmd)
```

```bash
import sqlite3
conn = sqlite3.connect("people.db")
people = [
    "1, 'Fairy', 'Tooth', '2022-10-08 09:15:10'",
    "2, 'Ruprecht', 'Knecht', '2022-10-08 09:15:13'",
    "3, 'Bunny', 'Easter', '2022-10-08 09:15:27'",
]
for person_data in people:
     insert_cmd = f"INSERT INTO person VALUES ({person_data})"
     conn.execute(insert_cmd)
conn.commit()
```

**Interact With the Database**

```bash
import sqlite3
conn = sqlite3.connect("people.db")
cur = conn.cursor()
cur.execute("SELECT * FROM person")
people = cur.fetchall()
for person in people:
    print(person)
```

**Configure Your Database**
marshmallow is a library for object serialization and deserialization. It can be used to convert complex data types, such as objects, to and from native Python data types. marshmallow is commonly used with SQLAlchemy to serialize and deserialize database objects.
```python
# config.py

import pathlib
import connexion
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow

basedir = pathlib.Path(__file__).parent.resolve()
connex_app = connexion.App(__name__, specification_dir=basedir)

app = connex_app.app
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{basedir / 'people.db'}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
ma = Marshmallow(app)
```

Model Data With SQLAlchemy

```python
# models.py

from datetime import datetime
from config import db

class Person(db.Model):
    __tablename__ = "person"
    id = db.Column(db.Integer, primary_key=True)
    lname = db.Column(db.String(32), unique=True)
    fname = db.Column(db.String(32))
    timestamp = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow
    )
```

Serialize Data With Marshmallow

```python
# models.py

from datetime import datetime
from config import db, ma

class Person(db.Model):
    __tablename__ = "person"
    id = db.Column(db.Integer, primary_key=True)
    lname = db.Column(db.String(32), unique=True)
    fname = db.Column(db.String(32))
    timestamp = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow
    )

class PersonSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Person
        load_instance = True
        sqla_session = db.session

person_schema = PersonSchema()
people_schema = PersonSchema(many=True)
```
update people.py to deal with the database
