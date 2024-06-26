
## API design 

|Action |HTTP Verb| URL Path| 	Description|
|Read 	|GET |	/api/people |   	Read a collection of people.|
|Create |POST| 	/api/people |   	Create a new person.|
|Read 	|GET |	/api/people/<lname>|Read a particular person.|
|Update |PUT |	/api/people/<lname>| 	Update an existing person.|
|Delete|DELETE| /api/people/<lname>| 	Delete an existing person.|


**Create a Virtual Environment**

```bash
$ python3 -m venv venv
$ source venv/bin/activate
```

**add app.py **

```pyhton 
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("home.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
```

**add templates/home.html**

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
        Hello, World!
    </h1>
</body>
</html>
```

**Create the API Configuration File**

```bash
# swagger.yml

openapi: 3.0.0
info:
  title: "RP Flask REST API"
  description: "An API about people and notes"
  version: "1.0.0"

servers:
  - url: "/api"

paths:
  /people:
    get:
      operationId: "people.read_all"
      tags:
        - "People"
      summary: "Read the list of people"
      responses:
        "200":
          description: "Successfully read people list"
```

**edit app.py**

```python
# app.py

from flask import render_template # Remove: import Flask
import connexion

app = connexion.App(__name__, specification_dir="./")
app.add_api("swagger.yml")

@app.route("/")
def home():
    return render_template("home.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
```

** add people.py**

```python
# people.py

from datetime import datetime

def get_timestamp():
    return datetime.now().strftime(("%Y-%m-%d %H:%M:%S"))

PEOPLE = {
    "Fairy": {
        "fname": "Tooth",
        "lname": "Fairy",
        "timestamp": get_timestamp(),
    },
    "Ruprecht": {
        "fname": "Knecht",
        "lname": "Ruprecht",
        "timestamp": get_timestamp(),
    },
    "Bunny": {
        "fname": "Easter",
        "lname": "Bunny",
        "timestamp": get_timestamp(),
    }
}

def read_all():
    return list(PEOPLE.values())
```

**Work With Components**
are building blocks in your OpenAPI specification that you can reference from 
other parts of your specification.
```yaml
components:
  schemas:
    Person:
      type: "object"
      required:
        - lname
      properties:
        fname:
          type: "string"
        lname:
          type: "string"
```

**Create a New Person**
```yaml
paths:
  /people:
    get:
        # ...
    post:
      operationId: "people.create"
      tags:
        - People
      summary: "Create a person"
      requestBody:
          description: "Person to create"
          required: True
          content:
            application/json:
              schema:
                x-body-name: "person"
                $ref: "#/components/schemas/Person"
      responses:
        "201":
          description: "Successfully created person"
```

### Handle a Person

**read a person**

```yaml
# swagger.yml

# ...

components:
  schemas:
    # ...
  parameters:
    lname:
      name: "lname"
      description: "Last name of the person to get"
      in: path
      required: True
      schema:
        type: "string"

paths:
  /people:
    # ...
  /people/{lname}:
    get:
      operationId: "people.read_one"
      tags:
        - People
      summary: "Read one person"
      parameters:
        - $ref: "#/components/parameters/lname"
      responses:
        "200":
          description: "Successfully read person"
```
and add read_one function to people.py
```python
# people.py
**read a person**
def read_one(lname):
    if lname in PEOPLE:
        return PEOPLE[lname]
    else:
        abort(
            404, f"Person with last name {lname} not found"
        )
```
**update a person**
```yaml
 swagger.yml

# ...

paths:
  /people:
    # ...
  /people/{lname}:
    get:
        # ...
    put:
      tags:
        - People
      operationId: "people.update"
      summary: "Update a person"
      parameters:
        - $ref: "#/components/parameters/lname"
      responses:
        "200":
          description: "Successfully updated person"
      requestBody:
        content:
          application/json:
            schema:
              x-body-name: "person"
              $ref: "#/components/schemas/Person"
```

and add update function to people.py
```python
# people.py
def update(lname, person):
    if lname in PEOPLE:
        PEOPLE[lname]["fname"] = person.get("fname", PEOPLE[lname]["fname"])
        PEOPLE[lname]["timestamp"] = get_timestamp()
        return PEOPLE[lname]
    else:
        abort(
            404,
            f"Person with last name {lname} not found"
        )
```
**delete a person**
```yaml
# swagger.yml

# ...

paths:
  /people:
    # ...
  /people/{lname}:
    get:
        # ...
    put:
        # ...
    delete:
      tags:
        - People
      operationId: "people.delete"
      summary: "Delete a person"
      parameters:
        - $ref: "#/components/parameters/lname"
      responses:
        "204":
          description: "Successfully deleted person"
```
and add delete function to people.py
```python
# people.py

from flask import abort, make_response

# ...

def delete(lname):
    if lname in PEOPLE:
        del PEOPLE[lname]
        return make_response(
            f"{lname} successfully deleted", 200
        )
    else:
        abort(
            404,
            f"Person with last name {lname} not found"
        )
```