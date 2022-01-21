CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    email VARCHAR UNIQUE NOT NULL,
    password VARCHAR NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    school VARCHAR NOT NULL,
    date_joined DATE NOT NULL
);