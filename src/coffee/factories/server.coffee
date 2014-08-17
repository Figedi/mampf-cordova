srv = ['$http', 'config', ($http, config) ->
  baseHTTP = (opts) ->
    $http({
      method: opts.method
      url: "#{config.server}"
      data: opts.data})
  {
    create: (opts) ->
      baseHTTP(angular.extend(opts, { method: 'POST' }))
    update: (opts) ->
      baseHTTP(angular.extend(opts, { method: 'PUT' }))
    delete: (opts) ->
      baseHTTP(angular.extend(opts, { method: 'DELETE' }))
    get: (opts) ->
      baseHTTP(angular.extend(opts, { method: 'GET' }))
  }
]

module.exports = srv
