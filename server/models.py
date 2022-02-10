from .app import db
from sqlalchemy.dialects.postgresql import JSON


class Project(db.Model):
    __tablename__ = 'projects'

    project_id = db.Column(db.Integer, primary_key=True)
    teacher_id = db.Column(db.String(), nullable=False)
    project_code = db.Column(db.String(), unique=True, nullable=False)
    title = db.Column(db.String(), nullable=False)
    description = db.Column(db.Text(), nullable=False)
    prompt = db.Column(db.Text(), nullable=False)
    category = db.Column(db.String(), nullable=False)
    end_date = db.Column(db.Date(), nullable=False)
    iv_info_id = db.Column(
        db.Integer, db.ForeignKey('ivinfo.iv_info_id', ondelete='CASCADE')
    )
    dv_info_id = db.Column(
        db.Integer, db.ForeignKey('dvinfo.dv_info_id', ondelete='CASCADE')
    )

    iv_info = db.relationship(
        'IVInfo', backref='parent', cascade='all, delete'
    )
    dv_info = db.relationship(
        'DVInfo', backref='parent', cascade='all, delete'
    )
    observation = db.relationship(
        'Observation', backref='parent', cascade='all, delete'
    )

    def __init__(self, teacher_id, project_code, title, description,
                 prompt, category, end_date, iv_info_id, dv_info_id):
        self.teacher_id = teacher_id
        self.project_code = project_code
        self.title = title
        self.description = description
        self.prompt = prompt
        self.category = category
        self.end_date = end_date
        self.iv_info_id = iv_info_id
        self.dv_info_id = dv_info_id

    def __repr__(self):
        return f'Project {self.project_code} {self.title}'


class IVInfo(db.Model):
    __tablename__ = 'ivinfo'

    iv_info_id = db.Column(db.Integer, primary_key=True)
    iv_name = db.Column(db.String(), nullable=False)
    iv_type = db.Column(db.String(), nullable=False)
    iv_units = db.Column(db.String())
    iv_accepted = db.Column(JSON)

    def __init__(self, iv_name, iv_type, iv_units, iv_accepted):
        self.iv_name = iv_name
        self.iv_type = iv_type
        self.iv_units = iv_units
        self.iv_accepted = iv_accepted

    def __repr__(self):
        return f'IVInfo {self.iv_name} {self.iv_type}'


class DVInfo(db.Model):
    __tablename__ = 'dvinfo'

    dv_info_id = db.Column(db.Integer, primary_key=True)
    dv_name = db.Column(db.String(), nullable=False)
    dv_type = db.Column(db.String(), nullable=False)
    dv_units = db.Column(db.String())
    dv_accepted = db.Column(JSON)

    def __init__(self, dv_name, dv_type, dv_units, dv_accepted):
        self.dv_name = dv_name
        self.dv_type = dv_type
        self.dv_units = dv_units
        self.dv_accepted = dv_accepted

    def __repr__(self):
        return f'DVInfo {self.dv_name} {self.dv_type}'


class Observation(db.Model):
    __tablename__ = 'observations'

    obs_id = db.Column(db.Integer, primary_key=True)
    project_id = db.Column(
        db.Integer, db.ForeignKey('projects.project_id', ondelete='CASCADE')
    )
    device_id = db.Column(db.String(), nullable=False)
    obs_vals = db.Column(JSON, nullable=False)
    obs_date = db.Column(db.Date(), nullable=False)

    def __init__(self, project_id, device_id, obs_vals, obs_date):
        self.project_id = project_id
        self.device_id = device_id
        self.obs_vals = obs_vals
        self.obs_date = obs_date

    def __repr__(self):
        return f'Observation {self.device_id} {self.obs_vals}'
