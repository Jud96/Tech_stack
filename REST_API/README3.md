## deal with Relational database


we will add for each person a list of notes

**modify models.py**

```python
class Note(db.Model):

    __tablename__ = "note"
    id = db.Column(db.Integer, primary_key=True)
    person_id = db.Column(db.Integer, db.ForeignKey("person.id"))
    content = db.Column(db.String, nullable=False)
    timestamp = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow
    )
class Person(db.Model):
    __tablename__ = "person"
    id = db.Column(db.Integer, primary_key=True)
    lname = db.Column(db.String(32), unique=True)
    fname = db.Column(db.String(32))
    timestamp = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow
    )
    notes = db.relationship(
        Note,
        backref="person",
        cascade="all, delete, delete-orphan",
        single_parent=True,
        order_by="desc(Note.timestamp)"
    )
```

**add build_databasee**
```bash 
$ python DB/build_database.py
```
**Show Notes in the Front End**

```html


<!-- templates/home.html -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RP Flask REST API</title>
</head>
<body>
    <h1>
        Hello, People!
    </h1>
    {% for person in people %}
    <h2>{{ person.fname }} {{ person.lname }}</h2>
    <ul>
        {% for note in person.notes %}
        <li>
            {{ note.content }}
        </li>
        {% endfor %}
    </ul>
    {% endfor %}
</body>
</html>
```

**Respond With Notes**

Next, check the /api/people endpoint of your API at http://localhost:8000/api/people:

```python
# people.py

# ...

def read_all():
    people = Person.query.all()
    person_schema = PersonSchema(many=True)
    return person_schema.dump(people)

# ...
```

```python
# models.py

# ...

class PersonSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Person
        load_instance = True
        sqla_session = db.session
        include_relationships = True
```

**Create a Notes Schema**

```python
# models.py

# ...

class Note(db.Model):
    # ...

class NoteSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Note
        load_instance = True
        sqla_session = db.session
        include_fk = True

class Person(db.Model):
    # ...

class PersonSchema(ma.SQLAlchemyAutoSchema):
    # ...

note_schema = NoteSchema()
# ...
```

## Handle Notes With Your REST API

**Read a Single Note**
 add the following to swagger.yml:
 1- add note_id parameter
 2- add /notes/{note_id} path
```yaml
# swagger.yml

# ...

components:
  schemas:
    # ...

  parameters:
    lname:
      # ...
    note_id:
      name: "note_id"
      description: "ID of the note"
      in: path
      required: true
      schema:
        type: "integer"
# ...

paths:
  /people:
    # ...
  /people/{lname}:
    # ...
  /notes/{note_id}:
    get:
      operationId: "notes.read_one"
      tags:
        - Notes
      summary: "Read one note"
      parameters:
        - $ref: "#/components/parameters/note_id"
      responses:
        "200":
          description: "Successfully read one note"
```
and add the following to notes.py:
```python
# notes.py

from flask import abort, make_response

from config import db
from models import Note, note_schema

def read_one(note_id):
    note = Note.query.get(note_id)

    if note is not None:
        return note_schema.dump(note)
    else:
        abort(
            404, f"Note with ID {note_id} not found"
        )
```
