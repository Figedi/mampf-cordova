srv = ['$http', 'config', ($http, config) ->

  callbackDone = ->
    console.log "aha done"

  callbackError = ->
    console.log "aha error"

  baseHTTP = (opts) ->
    $http({
      method: opts.method
      url: "#{config.server}"
      data: opts.data})
  {
    create: (opts) ->
      # i have no idea what im doing here
      baseHTTP(angular.extend(opts, {
        success: callbackDone
        error: callbackError
        method: 'POST'
        dataType: 'json'
        data: angular.fromJson(opts.data)
        contentType: 'application/json; charset=utf-8'
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
