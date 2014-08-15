ctrl = ['$scope', 'geoLocation', ($scope, geoLocation) ->
  $scope.position = null
  $scope.marker = null
  $scope.mapOptions =
    center: new google.maps.LatLng(35.784, -78.670)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  $scope.refreshPosition = ->
    geoLocation.getPosition().then (position) ->
      $scope.position = position
      lngLat = { lat: position.coords.latitude, lng: position.coords.longitude }
      $scope.mampfMap.setCenter(lngLat)

      if $scope.marker
        $scope.marker.setPosition(lngLat)
      else
        $scope.marker = new google.maps.Marker({ position: lngLat, map: $scope.mampfMap })
    , (err) ->
      console.log "lol noch ein geo fehler", err
  $scope.refreshPosition() #refresh for the first time controller is invoked
]

module.exports = ctrl
