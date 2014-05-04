password = (passwd) ->
  ac:      'ADMIN'
  act:     'act_change_passwd'
  passwd:  passwd
  confirm: passwd

password.schema =
  type: 'string'
  required: true

module.exports = password
