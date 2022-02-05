# Setup (Local)
- If you don't have the ```virtualenv``` package installed, execute the following in your terminal:
```
pip3 install virtualenv
```
- In your terminal, navigate to the Project's ```/server``` subdirectory and create a Python virtual environment by executing:
```
# Linux and Mac
python3 -m venv ./venv

# Windows Command Prompt
python -m venv venv
```
- Activate your virtual environment:
```
# Linux and Mac
source ./venv/bin/activate

# Windows Command Prompt
/venv/Scripts/activate.bat
```

- In your terminal, navigate to the Project's root directory ```osu-cs467-citizen-science``` and install the Project's dependencies:
```
pip3 install -r requirements.txt
```

- Install and configure the Postgres server on your machine (the following steps are for Mac, for Windows you can follow the steps [here](https://www.postgresqltutorial.com/install-postgresql/)):
```
# Install Postgres using the Homebrew package manager
brew install postgresql

# Start the Postgres server
brew services start postgresql

# Connect to the Postgres database
psql postgres

# Create a new database for the Project
CREATE DATABASE citizen_science;

# Exit Postgres
\q
```

### Database Clients
- Instead of using the terminal, you could also use a database client to connect to Postgres. [PGAdmin](https://www.pgadmin.org/) is a popular one.

### Database Credentials
- Within the Project's root directory ```osu-cs467-citizen-science```, create a ```.env``` file and add the following lines for the database credentials, where:
  - user = name of the root user on Postgres
  - password = password of the root user on Postgres
  - host = localhost or name of your machine
  - dbname = citizen_science
```
APP_SETTINGS=config.DevelopmentConfig
DATABASE_URL=postgresql://{user}:{password}@{host}:5432/{dbname}
```

### Create Database Tables
- Within the Project's root directory ```osu-cs467-citizen-science```, create the database tables by executing:
```
# Start Python interpreter
python3

# Import SQLAlchemy object
>>> from server.app import db

# Create database tables
>>> db.create_all()

# Exit Python interpreter
>>> exit()
```

### Running the App
- Within the Project's root directory ```osu-cs467-citizen-science```, run the app by executing:
```
gunicorn --bind 0.0.0.0:5000 server.app:app     
```

### Testing If Everything Works
- Use an API tool like [Postman](https://www.postman.com/) to send a POST request to http://0.0.0.0:5000/projects/create/1 using the below sample JSON data and verify that the projects table gets populated using either a database client or a terminal connection.
- Sample JSON data:
{
  "title": "Hair Color", 
  "description": "It's been shown that hair...", 
  "prompt": "Enter your the amount of people...", 
  "category": "Biological Sciences", 
  "end_date": "2022-02-02", 
  "iv_name": "Hair Color", 
  "iv_type": "String", 
  "iv_units": null, 
  "iv_accepted": {
    "String": ["Black", "Blonde", "Brown"]
  },
  "dv_name": "Hair Count", 
  "dv_type": "Num", 
  "dv_units": null, 
  "dv_accepted": {
    "Num": [0, 20]
  }
}
