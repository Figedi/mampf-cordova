srv = ['$http', 'config', ($http, config) ->

  baseHTTP = (opts) ->
    $http({
      method: opts.method
      url: "#{config.server}"
      data: opts.data})
  {
    create: (opts) ->
      # i have no idea what im doing here
      baseHTTP(angular.extend(opts, {
        method: "POST"
        data: JSON.stringify(opts.data, null, "  ")
        headers: {"Content-Type": "application/json"}
      }))
    update: (opts) ->
      baseHTTP(angular.extend(opts, { method: 'PUT' }))
    delete: (opts) ->
      baseHTTP(angular.extend(opts, { method: 'DELETE' }))
    get: (opts) ->
      baseHTTP(angular.extend(opts, { method: 'GET' }))
    callbackError: ->
      console.log "yay error"
    callbackDone: ->
      console.log "yay done"
  }
]

module.exports = srv
