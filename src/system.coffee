{status} = require './flags'

system = ({disableWifiWhileUsb}) ->
  act:          'act_rndis_config'
  getset:       'set'
  use_wifi_off: status disableWifiWhileUsb

system.schema =
  disableWifiWhileUsb:
    type: 'boolean'
    required: true

module.exports = system
