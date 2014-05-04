async      = require 'async'
request    = require 'request'
{validate} = require 'jsonschema'
{schema}   = require './schema'
config     = require '../config.json'

attached = require './attached'
auth     = require './auth'
battery  = require './battery'
network  = require './network'
password = require './password'
reboot   = require './reboot'
reset    = require './reset'
router   = require './router'
status   = require './status'
system   = require './system'
time     = require './time'
wifi     = require './wifi'

mainEndpoint = 'webmain.cgi'

class Photon

  constructor: (@hostname) ->

  sendRequest: (form, done = ->) ->
    jar = true
    timeout = 1000
    uri = "http://#{@hostname}/cgi-bin/#{form.endpoint or mainEndpoint}"
    request.post {form, jar, timeout, uri}, done

  handleResponse: (done) ->
    (error, response) -> done error, JSON.parse(response.body).data

  authenticate: (password, done) ->
    @sendRequest auth(password), done

  configure: ->
    errors = validate(config, schema).errors
    throw new Error ["Configuration file error"].concat(errors.map ({property, message}) -> "#{property} #{message}").join('\n') if errors.length

    requests =
      setupSystem:   (done) => @sendRequest system(config.system),     done
      setupTime:     (done) => @sendRequest time(config.time),         done
      setupWifi:     (done) => @sendRequest wifi(config.wifi),         done
      setupNetwork:  (done) => @sendRequest network(config.network),   done
      setupRouter:   (done) => @sendRequest router(config.router),     done
      setupPassword: (done) => @sendRequest password(config.password), done

    async.auto requests

  status: (done) ->
    @sendRequest status, @handleResponse(done)

  attached: (done) ->
    @sendRequest attached, @handleResponse(done)

  battery: (done) ->
    @sendRequest battery, @handleResponse(done)

  reset: ->
    @sendRequest reset

  reboot: ->
    @sendRequest reboot

module.exports = Photon
