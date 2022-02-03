from app import ma


class ProjectSchema(ma.Schema):
    class Meta:
        fields = (
            'project_id', 'teacher_id', 'project_code', 'title',
            'description', 'prompt', 'category', 'end_date',
            'iv_info_id', 'iv_name', 'iv_type', 'iv_units', 'iv_accepted',
            'dv_info_id', 'dv_name', 'dv_type', 'dv_units', 'dv_accepted'
        )

project_schema = ProjectSchema()
projects_schema = ProjectSchema(many=True)


class ObservationSchema(ma.Schema):
    class Meta:
        fields = (
            'obs_id', 'project_id', 'device_id', 'obs_vals', 'obs_date'
        )

observation_schema = ObservationSchema()
observations_schema = ObservationSchema(many=True)
