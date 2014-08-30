###*
 * @description Add-Location-Controller: Responsible for the add-location-page within the profile/
 * other views. This Controller provides a Map-Preview and the ability to set
 * markers and a Location Alias for that marker. After that, we can save it into
 * localstorage.
 *
 * @return {void} No explicit returnvalue needed
###
addLocation = ['$scope', 'config', 'storage', 'sharedData', 'geoLocation', ($scope, config, storage, sharedData, geoLocation) ->

  storage.bind($scope, 'locations', { defaultValue: config.dummyLocations })
  sharedData.locations = $scope.locations #alias sharedData.locations with current scope
  $scope.locationModel = "Ort #{$scope.locations.length + 1}"


  $scope.mapOptions =
    center: new google.maps.LatLng(53.8353,10.6349)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  $scope.markerExistent = ->
    $scope.marker?

  $scope.addNewLocation = ->
    return false unless $scope.marker?

    lat = $scope.marker.getPosition().lat()
    lng = $scope.marker.getPosition().lng()
    location =
      locationName: $scope.locationModel
      selected: false
      latitude: lat
      longitude: lng
    # add new location to sharedData and storage, saving is done
    sharedData.locations.push(location)
    storage.set('locations', sharedData.locations)


  $scope.mapClick = ($event, $params) ->
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

module.exports = addLocation
