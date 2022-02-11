import csv
import io
import os
from datetime import date
from dotenv import find_dotenv, load_dotenv
from flask import Flask, jsonify, make_response, request
from flask_cors import CORS
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


load_dotenv(find_dotenv())

app = Flask(
    __name__, static_folder='../admin_frontend/dist/', static_url_path='/'
)
app.config.from_object(os.getenv('APP_SETTINGS', 'config.DevelopmentConfig'))

db = SQLAlchemy(app)
ma = Marshmallow(app)
CORS(app)

from .models import *
from .schemas import *


# Catch-all endpoint for serving Vue SPA
@app.route('/', defaults={'path': ''})
@app.route('/<string:path>')
@app.route('/<path:path>')
def catch_all(path):

    return app.send_static_file('index.html')


# Returns a list of projects for teacher with id <teacher_id>
@app.route('/projects/<teacher_id>', methods=['GET'])
def get_projects(teacher_id):
    projects = Project.query.filter(Project.teacher_id == teacher_id)

    return projects_schema.jsonify(projects)


def get_project_info(project_id):
    """Returns a project's details, iv info, and dv info"""
    project_info = db.session.query(Project, IVInfo, DVInfo) \
        .join(IVInfo, IVInfo.iv_info_id == Project.iv_info_id) \
        .join(DVInfo, DVInfo.dv_info_id == Project.dv_info_id) \
        .filter(Project.project_id == project_id).one()

    return project_info


# Returns info for project with id <project_id>
@app.route('/projects/info/<project_id>', methods=['GET'])
def get_project_by_id(project_id):

    return projects_schema.jsonify(get_project_info(project_id))


# Updates project with id <project_id>
@app.route('/projects/info/<project_id>', methods=['PUT'])
def update_project(project_id):
    db.session.query(Project).filter_by(
        project_id=project_id).update(request.json)
    db.session.commit()

    return project_schema.jsonify(Project.query.get(project_id))


# Deletes project with id <project_id>
@app.route('/projects/info/<project_id>', methods=['DELETE'])
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
@app.route('/projects/create/<teacher_id>', methods=['POST', 'OPTIONS'])
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
            f'{date.today().year}-{new_project.project_id}'
        )
        db.session.commit()

        return project_schema.jsonify(new_project)
    else:
        return jsonify(error='Data must be JSON formatted!')


# Returns info for project with code <project_code>
@app.route('/field_app/<project_code>', methods=['GET'])
def get_project_by_code(project_code):
    project_info = db.session.query(Project, IVInfo, DVInfo) \
                   .join(IVInfo, IVInfo.iv_info_id == Project.iv_info_id) \
                   .join(DVInfo, DVInfo.dv_info_id == Project.dv_info_id) \
                   .filter(Project.project_code == project_code).one()

    return projects_schema.jsonify(project_info)


# Adds an observation to project with code <project_code>
# for student device with id <device_id>
@app.route('/field_app/<project_code>/<device_id>', methods=['POST'])
def create_obs(project_code, device_id):
    if request.is_json:
        project = Project.query.filter(
            Project.project_code == project_code).one()
        new_obs = Observation(
            project_id=project.project_id,
            device_id=device_id,
            obs_vals=request.json['obs_vals'],
            obs_date=date.today()
        )

        db.session.add(new_obs)
        db.session.commit()

        return observation_schema.jsonify(new_obs)
    else:
        return jsonify(error='Data must be JSON formatted!')


# Returns a list of observations already made by student device
# with id <device_id> to project with project code <project_code>
@app.route('/field_app/<project_code>/<device_id>', methods=['GET'])
def get_obs(project_code, device_id):
    project = Project.query.filter(Project.project_code == project_code).one()
    observations = Observation.query.filter(
        Observation.project_id == project.project_id and
        Observation.device_id == device_id
    )

    return observations_schema.jsonify(observations)


# Updates observation with id <obs_id>
@app.route('/field_app/<int:obs_id>', methods=['PUT'])
def update_obs(obs_id):
    db.session.query(Observation).filter_by(obs_id=obs_id).update(request.json)
    observation = Observation.query.get(obs_id)
    observation.obs_date = date.today()
    db.session.commit()

    return observation_schema.jsonify(observation)


# Deletes observation with id <obs_id>
@app.route('/field_app/<int:obs_id>', methods=['DELETE'])
def delete_obs(obs_id):
    observation = Observation.query.get(obs_id)
    db.session.delete(observation)
    db.session.commit()

    return observation_schema.jsonify(observation)


# Returns a list of observations for project with id <project_id>
@app.route('/projects/info/<project_id>/results', methods=['GET'])
def get_results(project_id):
    observations = Observation.query.filter(
        Observation.project_id == project_id).all()

    return observations_schema.jsonify(observations)


# Extracts observations for project with id <project_id>
# into a csv file and downloads it
@app.route('/projects/info/<project_id>/results/download', methods=['GET'])
def download_results(project_id):
    observations = Observation.query.filter(
        Observation.project_id == project_id).all()
    project_info = get_project_info(project_id)

    headers = [
        'Observation ID', 'Device ID', f'{project_info[1].iv_name}',
        f'{project_info[2].dv_name}', 'Observation Date'
    ]
    rows = [
        [
            obs.obs_id, obs.device_id, obs.obs_vals['iv_val'],
            obs.obs_vals['dv_val'], obs.obs_date.strftime('%m/%d/%Y')
        ] for obs in observations
    ]

    # Code below adapted from
    # https://stackoverflow.com/questions/26997679/writing-a-csv-from-flask-framework
    # Date Retrieved: 10-Feb-2022
    si = io.StringIO()
    cw = csv.writer(si)
    cw.writerow(headers)
    cw.writerows(rows)
    results = make_response(si.getvalue())
    results.headers["Content-Disposition"] = "attachment; filename=results.csv"
    results.headers["Content-type"] = "text/csv"

    return results


if __name__ == '__main__':
    app.run()
