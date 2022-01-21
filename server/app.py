import os

from datetime import date
from dotenv import load_dotenv, find_dotenv
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

load_dotenv(find_dotenv())
host = os.environ.get('HOST')
user = os.environ.get('USER')
pwd = os.environ.get('PWD')
db_name = os.environ.get('DB')

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = f'postgresql://{user}:{pwd}@{host}:5432/{db_name}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
migrate = Migrate(app, db)

from models import *


@app.route('/auth/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        if request.is_json:
            data = request.get_json()
            new_teacher = TeachersModel(
                email=data['email'],
                password=data['password'],
                first_name=data['firstname'],
                last_name=data['lastname'],
                school=data['school'],
                date_joined=date.today()
                )
            db.session.add(new_teacher)
            db.session.commit()
            return f'Successfully added {new_teacher} to database'
        else:
            return 'Data must be JSON formatted!'

if __name__ == '__main__':
    app.run(debug=True)
