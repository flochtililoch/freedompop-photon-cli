module.exports = (password) ->
  act:    'act_login'
  login:  'login'
  passwd: new Buffer(password).toString('base64')
