{status, numericStatus} = require './flags'

workingModes = [
  '802.11b'
  '802.11g'
  '802.11bg'
]

txPowers = [
  'long'
  'medium'
  'short'
]

wpaModes = [
  'WPA-PSK'
  'WPA2-PSK'
  'WPA/WPA2-Mixed PSK'
]

encryptions = [
  'Auto'
  'TKIP'
  'AES-CCMP'
]

wifi = ({broadcastSsid, channelNum, enable, encryption, password, ssid, txPower, workingMode, wpaMode}) ->
  act:           'act_ar6000_set'
  channel_num:    channelNum
  ENABLE_WIFI:    numericStatus enable
  mode80211:      "index#{workingModes.indexOf workingMode}"
  security_mode:  'index2'
  ssid:           ssid
  ssid_broadcast: status broadcastSsid
  txpower:        "index#{txPowers.indexOf txPower}"
  wpa_mode:       "index#{wpaModes.indexOf wpaMode}"
  wpa_pass:       password
  wpa_type:       "index#{encryptions.indexOf encryption}"

wifi.schema =
  type: 'object'
  properties:
    enable:
      type: 'boolean'
      required: true
    ssid:
      type: 'string'
      required: true
    password:
      type: 'string'
      required: true
      minLength: 8
      maxLength: 63
    broadcastSsid:
      type: 'boolean'
      required: true
    wpaMode:
      type: 'string'
      required: true
      pattern: "^(#{wpaModes.join '|'})$"
    encryption:
      type: 'string'
      required: true
      pattern: "^(#{encryptions.join '|'})$"
    channelNum:
      type: 'string'
      required: true
      pattern: '^[0-7]$' # 0 = Auto
    workingMode:
      type: 'string'
      required: true
      pattern: "^(#{workingModes.join '|'})$"
    txPower:
      type: 'string'
      required: true
      pattern: "^(#{txPowers.join '|'})$"

module.exports = wifi
