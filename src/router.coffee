{status} = require './flags'

router = ({webRemoteAccess, pingFromWeb, upnp, dmzHost, portForwarding}) ->
  params =
    act:                  'act_network_set'
    dmz_host_ip:          if dmzHost then dmzHost else null    # DMZ IP Address XXX.XXX.XXX.??
    enable_dmz:           status dmzHost                       # Enable DMZ Host
    enable_ping_from_wan: status pingFromWeb
    enable_remote_access: status webRemoteAccess
    ENABLE_UPNP:          status upnp                          # Enable UPnP IGD
    RESTART_NAT:          status true
    SAVE_PM_RULES:        status true

  for {ip, from, to, protocol, name}, i in portForwarding
    n = i + 1
    params["PM_ENABLE_#{n}"] = status true
    params["PM_HOST_#{n}"]   = ip
    params["PM_NAME_#{n}"]   = name
    params["PM_PORT_#{n}"]   = "#{from}:#{to}"
    params["PM_PROTO_#{n}"]  = protocol

  params

router.schema =
  type: 'object'
  properties:
    pingFromWeb:
      type: 'boolean'
      required: true
    webRemoteAccess:
      type: 'boolean'
      required: true
    upnp:
      type: 'boolean'
      required: true
    dmzHost:
      type: 'string'
      required: true
    portForwarding:
      type: 'array'
      required: false
      items:
        type: 'object'
        properties:
          ip:
            type: 'string'
            required: true
          from:
            type: 'string'
            required: true
          to:
            type: 'string'
            required: true
          protocol:
            type: 'string'
            required: true
          name:
            type: 'string'
            required: true

module.exports = router
