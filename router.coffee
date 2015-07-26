#Requires

Router = require 'koa-router'
request = require 'koa-request'
_ = require 'underscore' 
hbs = require 'koa-handlebars'
mongoose = require 'mongoose'
require './models/person'

#Schema

Person = mongoose.model('Person')

#Router

router = new Router()
router.use hbs(defaultLayout: 'main', {title: 'App'})
module.exports = router

#Routes

router.get '/', () ->
    yield @render 'index', name:'Hi'

router.get '/people', () ->
    users = []
    yield Person.find {}.lean, (err, coll) ->
        if err?
            console.log err
        users = coll || "empty"
    if users? then
        yield @render 'people', people: users
    else
        yield @render 'people', people: 'Could not get users'

router.get '/fetch', () ->
    options = url: 'http://api.fixer.io/latest'
    resp = yield request options
    if resp?
        json = JSON.parse resp.body
        console.log json.rates.PLN


router.post '/add', (next) ->
    if @request.body?
        console.log @request.body
        r = new Person(@request.body)
        r.save()
        @response.body =  'string'
    yield next

router.post '/num', (next) ->
    if @request.body?
        arr = _.values @request.body
        result = 
        switch +arr[0] > +arr[1]
            when true then result = _.shuffle arr else result = _.max arr
        console.log result
        @response.body = "ok"
    yield next