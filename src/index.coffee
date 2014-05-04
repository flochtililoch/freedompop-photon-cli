Photon = require './photon'

options =
  configure: 'Apply configuration to factory device.'
  reset: 'Reset device configuration to factory settings.'
  status: 'Get device connection status.'
  battery: 'Get device battery status.'
  attached: 'Get attached hosts.'
  reboot: 'Reboot device.'

args = process.argv.slice(2)
action = args[0]
password = args[1] or 'admin'
host = args[2] or 'localhost:8090'

unless options[action]
  console.log "Options:"
  console.log "  #{action}: #{description}" for action, description of options
  return

photon = new Photon host
photon.authenticate password, ->
  photon[action] (err, results) ->
    console.log results
