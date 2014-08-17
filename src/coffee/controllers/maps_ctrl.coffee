ctrl = ['$scope', 'geoLocation', 'storage', 'config', 'sharedData', 'ngDialog', ($scope, geoLocation, storage, config, sharedData, ngDialog) ->

#ctrl = ['$scope', 'geoLocation', 'storage', 'config', 'sharedData', ($scope, geoLocation, storage, config, sharedData, ngDialog) ->
  # bind storage to scope, thus creating two way binding between
  # scope AND localstorage, every scope change is saved in localstorage
  storage.bind($scope, 'cities', { defaultValue: config.dummyCities })

  $scope.cityCount = $scope.cities.length
  $scope.selectedMap = null
  $scope.position = null
  $scope.marker = null
  $scope.locationModel = "Ort #{$scope.cityCount + 1}"
  $scope.mapOptions =
    center: new google.maps.LatLng(35.784, -78.670)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  #ngDialogProvider.setDefaults(
  #  className: 'ngdialog-theme-default'
  #  plain: true
  #  showClose: true
  #  closeByDocument: true
  #  closeByEscape: true
  #)


  $scope.toggleCity = (city) ->
    c.selected = false for c in $scope.cities
    city.selected = not city.selected
    sharedData.cities = $scope.cities

  $scope.openModalWindow = (latitude, longitude) ->
    modalCenter = { lat: latitude, lng: longitude }
    $scope.modalMapOptions =
      center: modalCenter
      zoom: 15
      mapTypeId: google.maps.MapTypeId.ROADMAP
    new google.maps.Marker({ position: modalCenter, map: $scope.modalMampfMap })
    ngDialog.open({template: 'partials/profile/modalWindowLocation.html'})

  $scope.deleteAllSelected = ->
    $scope.deleteCity(city) for city in $scope.cities.filter((city) -> city.selected)

  $scope.deleteCity = (city) ->
    $scope.cities.splice($scope.cities.indexof(city),1)

  $scope.addNewLocation = () ->
    lat = $scope.marker.getPosition().lat()
    lng = $scope.marker.getPosition().lng()
    $scope.cities.push({ cityName: $scope.locationModel, selected: false, latitude: lat, longitude: lng })

  $scope.mapClick = ($event, $params) ->
    console.log "event", $params
    $scope.setMarkerPosition($params[0].latLng.lat(),$params[0].latLng.lng())

  $scope.setMarkerPosition = (lat,lng) ->
    $scope.marker.setPosition(new google.maps.LatLng(lat, lng))

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
