// Generated by CoffeeScript 2.0.0-beta7
module.exports.statusFlag = function (flag) {
  if (flag) {
    return 'YES';
  } else {
    return 'NO';
  }
};
module.exports.statusFlagAlt = function (flag) {
  if (flag) {
    return '1';
  } else {
    return '0';
  }
};
module.exports.requiredString = function (pattern) {
  var hash;
  if (null == pattern)
    pattern = null;
  hash = {
    type: 'string',
    required: true
  };
  if (pattern)
    hash.pattern = pattern;
  return hash;
};
module.exports.requiredBoolean = {
  type: 'boolean',
  required: true
};