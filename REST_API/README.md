
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