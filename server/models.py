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
