shared = ->
  returnObj =
    contacts: []
    locations: []
    $wipe: (args...) -> returnObj[arg] = [] for arg in args when returnObj[arg]?
  returnObj
module.exports = shared
