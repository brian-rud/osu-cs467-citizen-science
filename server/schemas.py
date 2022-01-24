from app import ma


class TeacherSchema(ma.Schema):
    class Meta:
        fields = (
            'teacher_id', 'email', 'password',
            'first_name', 'last_name', 'school', 'date_joined'
            )

teacher_schema = TeacherSchema()
teachers_schema = TeacherSchema(many=True)


class ProjectSchema(ma.Schema):
    class Meta:
        fields = (
            'project_id', 'teacher_id', 'project_code',
            'title', 'description', 'prompt', 'category', 'end_date'
            )

project_schema = ProjectSchema()
projects_schema = ProjectSchema(many=True)
