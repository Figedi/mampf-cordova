shared = [ 'config', (config) ->
  returnObj =
    contacts: config.shared.contacts
    locations: config.shared.locations
    $wipe: (args...) ->
      for arg in args
        continue unless returnObj[arg]?
        if c = config.shared[arg]
          returnObj[arg] = c
        else
          delete returnObj[arg]
  returnObj
]
module.exports = shared
