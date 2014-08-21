srv = ['$http', 'config', ($http, config) ->

  sendRequest = (inputdata) ->
    $http({
      method: 'POST',
      url:"#{config.server}",
      data: JSON.stringify(inputdata, null, '  '),
      headers: {'Content-type': 'application/json'}
    })

]

module.exports = srv
