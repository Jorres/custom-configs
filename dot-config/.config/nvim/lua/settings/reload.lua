local ok, plenary_reload = pcall(require, "plenary.reload")

local reloader = nil

if not ok then
  reloader = require
else
  reloader = plenary_reload.reload_module
end

RELOAD = function(...)
  return reloader(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
