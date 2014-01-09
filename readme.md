Heroku ElephantSQL plugin
==================

Heroku CLI plugin that helps you manage your ElephantSQL database.

    heroku plugins:install git@github.com:ElephantSQL/elephantsql-heroku-plugin.git

Connect to your ElephantSQL database:

    heroku elephantsql:psql

Dump the ElephantSQL database to your local database:

    heroku elephantsql:pg_dump | psql mydb

Upload a database to ElephantSQL:

   pg_dump --clean --no-owner --no-acl mydb | heroku elephantsql:psql


