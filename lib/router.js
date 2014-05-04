// Generated by CoffeeScript 2.0.0-beta7
void function () {
  var router, status;
  status = require('./flags').status;
  router = function (param$) {
    var cache$, cache$1, dmzHost, from, i, ip, n, name, params, pingFromWeb, portForwarding, protocol, to, upnp, webRemoteAccess;
    {
      cache$ = param$;
      webRemoteAccess = cache$.webRemoteAccess;
      pingFromWeb = cache$.pingFromWeb;
      upnp = cache$.upnp;
      dmzHost = cache$.dmzHost;
      portForwarding = cache$.portForwarding;
    }
    params = {
      act: 'act_network_set',
      dmz_host_ip: dmzHost ? dmzHost : null,
      enable_dmz: status(dmzHost),
      enable_ping_from_wan: status(pingFromWeb),
      enable_remote_access: status(webRemoteAccess),
      ENABLE_UPNP: status(upnp),
      RESTART_NAT: status(true),
      SAVE_PM_RULES: status(true)
    };
    for (var i$ = 0, length$ = portForwarding.length; i$ < length$; ++i$) {
      {
        cache$1 = portForwarding[i$];
        ip = cache$1.ip;
        from = cache$1.from;
        to = cache$1.to;
        protocol = cache$1.protocol;
        name = cache$1.name;
      }
      i = i$;
      n = i + 1;
      params['PM_ENABLE_' + n] = status(true);
      params['PM_HOST_' + n] = ip;
      params['PM_NAME_' + n] = name;
      params['PM_PORT_' + n] = '' + from + ':' + to;
      params['PM_PROTO_' + n] = protocol;
    }
    return params;
  };
  router.schema = {
    type: 'object',
    properties: {
      pingFromWeb: {
        type: 'boolean',
        required: true
      },
      webRemoteAccess: {
        type: 'boolean',
        required: true
      },
      upnp: {
        type: 'boolean',
        required: true
      },
      dmzHost: {
        type: 'string',
        required: true
      },
      portForwarding: {
        type: 'array',
        required: false,
        items: {
          type: 'object',
          properties: {
            ip: {
              type: 'string',
              required: true
            },
            from: {
              type: 'string',
              required: true
            },
            to: {
              type: 'string',
              required: true
            },
            protocol: {
              type: 'string',
              required: true
            },
            name: {
              type: 'string',
              required: true
            }
          }
        }
      }
    }
  };
  module.exports = router;
}.call(this);