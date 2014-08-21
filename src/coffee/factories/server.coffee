srv = ['$http', 'config', ($http, config) ->

  baseHTTP = (opts) ->
    $http.post("#{config.server}",{
      withCredentials: true
      data: opts.data})
  {
    create: (opts) ->
      # i have no idea what im doing here
      baseHTTP(angular.extend(opts, {
        data: opts.data
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type, X-Requested-With',
        }
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
