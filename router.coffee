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

router.get '/', ->
    yield @render 'index', name:'Hi'

router.get '/people', ->
    
    users = yield Person.find {}, (err, coll) ->
        if err
            throw console.log err

    yield @render 'people', people: users || 'Could not get users'

router.get '/fetch', ->
    try 
        resp = yield request url: 'http://api.fixer.io/latest', json: true
        console.log resp.body.rates.PLN
    catch err then throw  console.log err


router.post '/add', ->
    { body } = @request
    @throw 422 unless body
    console.log @request.body
    objToSave = new Person(@request.body)
    yield objToSave.save()
    @body =  'ok'

router.post '/num', ->
    { body } = @request
    @throw 422 unless body
    yield arr = _.values @request.body
    result = if +arr[0] > +arr[1]
            _.shuffle arr
        else _.max arr
    console.log result
    @body = 'ok'