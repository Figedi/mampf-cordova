srv = ['$http', 'config', ($http, config) ->

  {
    send: (data) ->
      # i have no idea what im doing here
      $http({
        method: 'POST'
        url: "#{config.server}"
        data: data
      })
  }
]

module.exports = srv
