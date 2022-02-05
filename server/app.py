import os
from datetime import date
from dotenv import load_dotenv, find_dotenv
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from .config_app import *


load_dotenv(find_dotenv())

app = Flask(__name__)
app.config.from_object(os.getenv('APP_SETTINGS', 'config_app.DevelopmentConfig'))

db = SQLAlchemy(app)
ma = Marshmallow(app)

from .models import *
from .schemas import *


@app.route('/', methods=['GET'])
def index():

    return 'Hello World!'


# Returns a list of projects for teacher with id <teacher_id>
@app.route('/projects/<int:teacher_id>', methods=['GET'])
def get_projects(teacher_id):
    projects = Project.query.filter(Project.teacher_id == teacher_id)

    return projects_schema.jsonify(projects)


# Returns info for project with id <project_id>
@app.route('/projects/info/<int:project_id>', methods=['GET'])
def get_project(project_id):
    project_info = db.session.query(Project, IVInfo, DVInfo) \
                   .join(IVInfo, IVInfo.iv_info_id == Project.iv_info_id) \
                   .join(DVInfo, DVInfo.dv_info_id == Project.dv_info_id) \
                   .filter(Project.project_id == project_id).one()

    return projects_schema.jsonify(project_info)


# Updates project with id <project_id>
@app.route('/projects/info/<int:project_id>', methods=['PUT'])
def update_project(project_id):
    db.session.query(Project).filter_by(project_id=project_id).update(request.json)
    db.session.commit()

    return project_schema.jsonify(Project.query.get(project_id))


# Deletes project with id <project_id>
@app.route('/projects/info/<int:project_id>', methods=['DELETE'])
def delete_project(project_id):
    project = Project.query.get(project_id)
    db.session.delete(project)
    db.session.commit()

    return project_schema.jsonify(project)


def create_iv_info(request):
    """Adds a new entry to IVInfo table and returns its id"""
    new_iv_info = IVInfo(
        iv_name=request.json['iv_name'],
        iv_type=request.json['iv_type'],
        iv_units=request.json['iv_units'],
        iv_accepted=request.json['iv_accepted']
    )

    db.session.add(new_iv_info)
    db.session.commit()

    return new_iv_info.iv_info_id


def create_dv_info(request):
    """Adds a new entry to DVInfo table and returns its id"""
    new_dv_info = DVInfo(
        dv_name=request.json['dv_name'],
        dv_type=request.json['dv_type'],
        dv_units=request.json['dv_units'],
        dv_accepted=request.json['dv_accepted']
    )

    db.session.add(new_dv_info)
    db.session.commit()

    return new_dv_info.dv_info_id


# Creates a new project for teacher with id <teacher_id>
@app.route('/projects/create/<int:teacher_id>', methods=['POST'])
def create_project(teacher_id):
    if request.is_json:
        new_project = Project(
            teacher_id=teacher_id,
            project_code='XXXX-X-X',
            title=request.json['title'],
            description=request.json['description'],
            prompt=request.json['prompt'],
            category=request.json['category'],
            end_date=request.json['end_date'],
            iv_info_id=create_iv_info(request),
            dv_info_id=create_dv_info(request)
        )

        db.session.add(new_project)
        db.session.commit()
        new_project.project_code = (
            f'{date.today().year}-{teacher_id}-{new_project.project_id}'
        )
        db.session.commit()

        return project_schema.jsonify(new_project)
    else:
        return jsonify(error='Data must be JSON formatted!')

if __name__ == '__main__':
    app.run()
