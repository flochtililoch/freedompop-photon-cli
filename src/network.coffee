{numericStatus} = require './flags'

network = ({ip, subnetMask, enableDhcp, rangeStart, rangeEnd, leaseTime, leaseReservations}) ->
  leaseReservations ?= []
  params =
    act:                'act_lan_config'
    getset:             'set'
    dhcp_enable:        numericStatus enableDhcp    # Enable DHCP Server
    DHCP_LEASE_TIME:    leaseTime                   # DHCP Lease Time (sec)
    local_ip_addr:      ip                          # DHCP Server IP Address
    range_start:        rangeStart                  # DHCP Starting IP Address
    range_end:          rangeEnd                    # DHCP Ending IP Address
    STATIC_LEASE_COUNT: leaseReservations.length    # DHCP Lease Reservation
    subnet_mask:        subnetMask

  for {macAddress, ip, hostname, macAddress}, i in leaseReservations
    n = i + 1
    params["MAC_HOST_#{n}"] = "#{hostname};#{macAddress}"
    params["SL_IP_#{n}"]    = ip
    params["SL_MAC_#{n}"]   = macAddress

  params

network.schema =
  type: 'object'
  properties:
    ip:
      type: 'string'
      required: true
    subnetMask:
      type: 'string'
      required: true
    enableDhcp:
      type: 'boolean'
      required: true
    rangeStart:
      type: 'string'
      required: true
    rangeEnd:
      type: 'string'
      required: true
    leaseTime:
      type: 'string'
      required: true
    leaseReservations:
      type: 'array'
      required: false
      items:
        type: 'object'
        properties:
          macAddress:
            type: 'string'
            required: true
          ip:
            type: 'string'
            required: true
          hostname:
            type: 'string'
            required: true

module.exports = network
