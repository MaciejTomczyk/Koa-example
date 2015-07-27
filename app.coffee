'use strict'
koa = require 'koa'
bodyParser = require 'koa-body-parser'
router = require './router'
mongoose = require 'mongoose'

connectDb = ->
    db = 'mongodb://localhost/local'
    mongoose.connect db

initApp = ->
    app = koa()
    app.use bodyParser()
    app.use router.middleware()
    app.listen 3000
    console.log 'up at port 3000'

connectDb()
initApp()