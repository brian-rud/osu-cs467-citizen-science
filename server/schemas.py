from app import ma


class TeacherSchema(ma.Schema):
    class Meta:
        fields = (
            'teacher_id', 'email', 'password',
            'first_name', 'last_name', 'school', 'date_joined'
            )

teacher_schema = TeacherSchema()
teachers_schema = TeacherSchema(many=True)
