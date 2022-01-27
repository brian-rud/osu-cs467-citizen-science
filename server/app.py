import os

from datetime import date
from dotenv import load_dotenv, find_dotenv
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
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
ma = Marshmallow(app)
migrate = Migrate(app, db)

from models import *
from schemas import *


@app.route('/auth/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        if request.is_json:
            new_teacher = TeachersModel(
                email=request.json['email'],
                password=request.json['password'],
                first_name=request.json['firstname'],
                last_name=request.json['lastname'],
                school=request.json['school'],
                date_joined=date.today()
                )
            db.session.add(new_teacher)
            db.session.commit()
            return teacher_schema.jsonify(new_teacher)
        else:
            return jsonify({'error': 'Data must be JSON formatted!'})


@app.route('/projects/create/<teacher_id>', methods=['POST'])
def create_project(teacher_id):
    if request.method == 'POST':
        if request.is_json:
            new_project = ProjectsModel(
                teacher_id=teacher_id,
                project_code=request.json['project_code'],
                title=request.json['title'],
                description=request.json['description'],
                prompt=request.json['prompt'],
                category=request.json['category'],
                end_date=request.json['end_date']
            )
            db.session.add(new_project)
            db.session.commit()
            return project_schema.jsonify(new_project)
        else:
            return jsonify({'error': 'Data must be JSON formatted!'})

if __name__ == '__main__':
    app.run(debug=True)
