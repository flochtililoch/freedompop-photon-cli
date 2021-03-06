module.exports.schema =
  id: 'PhotonConfig'
  type: 'object'
  properties:
    network:  require('./network').schema
    password: require('./password').schema
    router:   require('./router').schema
    system:   require('./system').schema
    time:     require('./time').schema
    wifi:     require('./wifi').schema
