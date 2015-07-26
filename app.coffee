'use strict'
#Requires

koa = require 'koa'
request = require 'koa-request'
bodyParser = require 'koa-body-parser'
router = require './router'
mount = require 'koa-mount'
serve = require 'koa-static'
mongoose = require 'mongoose'
_ = require 'underscore'
hbs = require 'koa-handlebars'

#Mongo Connection

db = 'mongodb://localhost/local'
mongoose.connect db

#App

app = koa()
app.use bodyParser()
app.use router.middleware()
app.listen 3000
console.log "up at port 3000"