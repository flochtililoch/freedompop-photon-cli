{status} = require './flags'

timezones = [
  'Hawaii Standard Time'
  'Alaska Standard Time'
  'Pacific Standard Time'
  'Phoenix Standard Time'
  'Mountain Standard Time'
  'Central Standard Time'
  'Eastern Standard Time'
  'Indiana Eastern Standard Time'
]

time = ({enable, ntpServer, dailightSaving, timezone}) ->
  act:        'act_ntp_config'
  getset:     'set'
  ENABLE_DST: status dailightSaving
  ENABLE_NTP: status enable
  NTP_SERVER: ntpServer
  TIME_ZONE:  "TZ2#{timezones.indexOf timezone}"

time.schema =
  type: 'object'
  properties:
    enable:
      type: 'boolean'
      required: true
    ntpServer:
      type: 'string'
      required: true
      pattern: "^(?:[-A-Za-z0-9]+\.)+[A-Za-z]{2,6}$"
    dailightSaving:
      type: 'boolean'
      required: true
    timezone:
      type: 'string'
      required: true
      pattern: "^#{timezones.join '|'}$"

module.exports = time
