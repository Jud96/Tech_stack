# config.py

import pathlib
import connexion
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow

#creates the variable basedir pointing to the directory that the program is running in
basedir = pathlib.Path(__file__).parent.resolve()
#uses the basedir variable to create the Connexion app instance and give it the path 
#to the directory that contains your specification file.
connex_app = connexion.App(__name__, specification_dir=basedir)

app = connex_app.app
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{basedir / 'people.db'}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
#initializes Marshmallow and allows it to work with 
#the SQLAlchemy components attached to the app
ma = Marshmallow(app)