#!/bin/sh

# Rails does not generally require you to restart the server; changes you make in files will be automatically picked up by the server.
bin/rails server

bin/rails generate controller Articles index --skip-routes

bin/rails generate model Article title:string body:text

bin/rails db:migrate

bin/rails routes

bin/rails generate migration AddStatusToArticles status:string
bin/rails generate migration AddStatusToComments status:string
