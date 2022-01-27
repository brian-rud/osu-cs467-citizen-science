from app import db


class TeachersModel(db.Model):
    __tablename__ = 'teachers'

    teacher_id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(), unique=True, nullable=False)
    password = db.Column(db.String(), nullable=False)
    first_name = db.Column(db.String(), nullable=False)
    last_name = db.Column(db.String(), nullable=False)
    school = db.Column(db.String(), nullable=False)
    date_joined = db.Column(db.Date(), nullable=False)

    def __init__(self, email, password, first_name, last_name, school, date_joined):
        self.email = email
        self.password = password
        self.first_name = first_name
        self.last_name = last_name
        self.school = school
        self.date_joined = date_joined

    def __repr__(self):
        return f'Teacher {self.first_name} {self.last_name} {self.school}'


class ProjectsModel(db.Model):
    __tablename__ = 'projects'

    project_id = db.Column(db.Integer, primary_key=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('teachers.teacher_id'))
    project_code = db.Column(db.String(), unique=True, nullable=False)
    title = db.Column(db.String(), nullable=False)
    description = db.Column(db.Text(), nullable=False)
    prompt = db.Column(db.Text(), nullable=False)
    category = db.Column(db.String(), nullable=False)
    end_date = db.Column(db.Date(), nullable=False)

    teachers = db.relationship('TeachersModel')

    def __init__(self, teacher_id, project_code, title, description, prompt, category, end_date):
        self.teacher_id = teacher_id
        self.project_code = project_code
        self.title = title
        self.description = description
        self.prompt = prompt
        self.category = category
        self.end_date = end_date

    def __repr__(self):
        return f'Project {self.project_code} {self.title}'
