local utils = require('core.utils')

utils.safe_require('config.opts')

utils.keys.set(require("config.binds").base)

utils.safe_require('core.auto_cmd')


utils.safe_require('plugins')
