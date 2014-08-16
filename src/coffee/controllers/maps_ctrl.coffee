ctrl = ['$scope', 'geoLocation', 'storage', 'config', ($scope, geoLocation, storage, config) ->

  # bind storage to scope, thus creating two way binding between
  # scope AND localstorage, every scope change is saved in localstorage
  storage.bind($scope, 'cities', { defaultValue: config.dummyCities })

  $scope.cityCount = $scope.cities.length
  $scope.selectedMap = null
  $scope.position = null
  $scope.marker = null
  $scope.mapOptions =
    center: new google.maps.LatLng(35.784, -78.670)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  $scope.toggleCity = (city) ->
    c.selected = false for c in $scope.cities
    city.selected = not city.selected

  $scope.refreshPosition = ->
    geoLocation.getPosition().then (position) ->
      $scope.position = position
      lngLat = { lat: position.coords.latitude, lng: position.coords.longitude }
      $scope.mampfMap.setCenter(lngLat) if $scope.mampfMap

      if $scope.marker
        $scope.marker.setPosition(lngLat)
      else
        $scope.marker = new google.maps.Marker({ position: lngLat, map: $scope.mampfMap })
    , (err) ->
      console.log "lol noch ein geo fehler", err
  $scope.refreshPosition() #refresh for the first time controller is invoked
]

module.exports = ctrl
