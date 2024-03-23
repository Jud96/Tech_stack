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