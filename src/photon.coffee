async          = require 'async'
request        = require 'request'
{EventEmitter} = require 'events'
{validate}     = require 'jsonschema'
{schema}       = require './schema'

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

class Photon extends EventEmitter

  constructor: (@hostname, @config) ->

  sendRequest: (form, done = ->) ->
    jar = true
    timeout = 1000
    uri = "http://#{@hostname}/cgi-bin/#{form.endpoint or mainEndpoint}"
    request.post {form, jar, timeout, uri}, done

  handleResponse: (done) ->
    (error, response) ->
      return done(error) if error?
      done noErr, JSON.parse(response.body).data

  authenticate: (password, done) ->
    @sendRequest auth(password), done

  configure: (_, done) ->
    errors = validate(@config, schema).errors
    throw new Error ["Configuration file error"].concat(errors.map ({property, message}) -> "#{property} #{message}").join('\n') if errors.length

    requests =
      setupSystem:   (done) => @sendRequest system(@config.system),     done
      setupTime:     (done) => @sendRequest time(@config.time),         done
      setupWifi:     (done) => @sendRequest wifi(@config.wifi),         done
      setupNetwork:  (done) => @sendRequest network(@config.network),   done
      setupRouter:   (done) => @sendRequest router(@config.router),     done
      setupPassword: (done) => @sendRequest password(@config.password), done

    async.auto requests, done

  status: (_, done) ->
    @sendRequest status, @handleResponse(done)

  attached: (_, done) ->
    @sendRequest attached, @handleResponse(done)

  battery: (_, done) ->
    @sendRequest battery, @handleResponse(done)

  reset: ->
    @sendRequest reset

  reboot: ->
    @sendRequest reboot

  monitor: (args, done) ->
    monitor = =>
      @status args, (err, status) ->
        console.log err, status
        unless err?
          {ID_WIFI_SSID, ID_WIMAX_STATUS} = status

          if ID_WIFI_SSID isnt @config.wifi.ssid
            @emit 'lost_configuration', status

          if ID_WIMAX_STATUS is 'CONNECTED' and @previousStatus?.ID_WIMAX_STATUS is 'CONNECTING'
            @emit 'connected', status

          if ID_WIMAX_STATUS isnt 'CONNECTED' and @previousStatus?.ID_WIMAX_STATUS is 'CONNECTED'
            @emit 'disconnected', status

          @previousStatus = status

      setTimeout monitor, args.delay or 1000

    monitor()

module.exports = Photon

noErr = null
