_ = require "lodash"

usage = """
  Usage:
    Error2()
    Error2(data)
    Error2(message)
    Error2(name, data)
    Error2(name, message)
    Error2(name, message, data)

  where
    typeof name     === "string"
    typeof message  === "string"
    typeof data     === "object"

  data object can contain name and message properties, which will therfore be used.
"""

Error2 = (name, message, data) ->
  if not message then switch typeof name
    when "object"
      data    = name
      name    = undefined

    when "string"
      message = name
      name    = undefined

  else if not data and typeof message is "object"
    data    = message
    message = undefined

  data    ?= {}
  message ?= data.message
  name    ?= data.name or "Error"

  if typeof message not in [ "string", "undefined" ]
    throw new Error2 "Unsupported message type" , (typeof message)  + "\n\n" + usage

  if typeof name    isnt "string"
    throw new Error2 "Unsupported name type"    , (typeof name)     + "\n\n" + usage

  if typeof data    isnt "object"
    throw new Error2 "Unsupported data type"    , (typeof data)     + "\n\n" + usage

  # name and message provided as arguments take precedent over data properties
  data.message  = message or ''
  data.name     = name    or 'Error'

  error = new Error message
  for key, value of data
    Object.defineProperty error, key,
      configurable: yes
      enumerable  : yes
      value       : value

  return error

module.exports = Error2
