local inspect = require("jorres.inspect")
local naughty = require("naughty")

local debug_module = {}

local function my_inspect(...)
  local args = {...}
  if #args == 0 then return 'nil' end
  local obj = args[1]
  if #args == 1 then
    if type(obj) == 'string' then
      return obj
    end
  else
    obj = args
  end
  return inspect(obj)
end

function debug_module._naughty_log(formatted, naughty_args)
  naughty_args = naughty_args or {}
  local default_naughty_args = {
    title="DEBUG",
    text=formatted,
    timeout=5,
  }
  for k, v in pairs(naughty_args) do
    default_naughty_args[k] = v
  end
  naughty.notify(default_naughty_args)
end

function debug_module.naughty_log(...)
  local formatted = my_inspect(...)
  debug_module._naughty_log(formatted)
end

function debug_module.naughty_log_eternal(...)
  local formatted = my_inspect(...)
  debug_module._naughty_log(formatted, {timeout=0})
end

debug_module.nlog = debug_module.naughty_log
debug_module.nloge = debug_module.naughty_log_eternal

return debug_module
