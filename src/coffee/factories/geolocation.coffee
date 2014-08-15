geo = ['$q', ($q) ->

  _get = ->
    deferred  = $q.defer()
    navigator.geolocation.getCurrentPosition (position) ->
       deferred.resolve(position)
    , (error) ->
      deferred.reject(error)
    , { maximumAge: 5000, timeout: 5000, enableHighAccuracy: true }

    deferred.promise
  {
    getPosition: _get
  }
]

module.exports = geo
