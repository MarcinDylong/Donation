# Donation App

Simple Donation App written in Django with use of PostgreSQL. Logged User can choose one or more categories of donation,
pick one Insititution which will be the beneficiary among availables (JS filter institution by donation categories choose by User),
fill the contact data and send notification.
<br/>
App in polish language, created within Portfolio Lab in Coderslab bootcamp.
<br>

## Key Notes
- Django 3.0.5;
- PostgreSQL Database, Django Native ORM;
- Authentication for user and reset password secured by Token (mails are sent within terminal);
- DjangoTests;
<br />

## How to use it

```bash
$ # Get the code
$ git clone https://github.com/MarcinDylong/Donation.git
$ cd FPL
$
$ # Virtualenv modules installation (Unix based systems)
$ virtualenv env
$ source env/bin/activate
$
$ # Virtualenv modules installation (Windows based systems)
$ # virtualenv env
$ # .\env\Scripts\activate
$
$ # Install modules
$ pip3 install -r requirements.txt
$
$ # Configure connection to database in .env.example
$ Create DB in PostgreSQL
$
$ # Provide your secret key, user name, password and database name
$ SECRET_KEY=[YOUR_SECRET_KEY]
$ DEBUG=FALSE
$ ALLOWED_HOSTS=.localhost,127.0.0.1
$ DATABASE_URL=postgres://[USER_NAME]:[PASSWORD]@localhost:5432/[YOUR_DATABASE_NAME]
$
$ # After this change name of the file to .env (remove .example)
$
$ # Create tables
$ python3 manage.py makemigrations
$ python3 manage.py migrate
$
$ # Import data from db_dump.sql
$ pg_restore -d [YOUR_DATABASE_NAME] < db_dump.sql
$
$ # Start the application
$ python3 manage.py runserver
$
$ # Access the web app in browser: http://127.0.0.1:8000/


## Heroku

App available on Heroku at:
- https://donationcharity.herokuapp.com/

Notice:
User create or reset password is unavailable, email client is not configure;
For demo logged as:
U: test_user@mail.pl
P: Haslo123!