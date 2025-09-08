local utils = require('core.utils')

utils.safe_require('config.opts')

utils.keys.set(require("config.binds").base)

utils.safe_require('core.auto_cmd')

local os_conf = utils.safe_require('config.os')
if os_conf then
  if os_conf.setup and type(os_conf.setup) == "function" then
    os_conf.setup()
  end
end

utils.safe_require('plugins')
