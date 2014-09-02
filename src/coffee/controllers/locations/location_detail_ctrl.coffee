###*
 * @description Location-Detail-Controller: Shows details about
 * a saved location on a map. Can rename locationname and relocate marker.
 *
 * Note that the $scope is inherited from ShowLocationsCtrl. Any changes made in
 * this controller are reflected in ShowLocationsCtrl and localstorage respectively
 *
 * @return {void} No explicit returnvalue needed
###
locationDetail = ['$scope', 'config', 'sharedData', '$timeout', 'storage', ($scope, config, sharedData, $timeout, storage) ->

  storage.bind($scope, 'locations', { defaultValue: config.dummyLocations })

  $scope.location = sharedData.location
  $scope.modalMapOptions =
    center: new google.maps.LatLng($scope.location.latitude, $scope.location.longitude)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  $scope.mapClick = ($event, $params) ->
    [lat, lng] = [$params[0].latLng.lat(), $params[0].latLng.lng()]
    $scope.marker.setPosition(new google.maps.LatLng(lat, lng))
    $scope.location.longitude = lng
    $scope.location.latitude = lat

  $scope.refreshPosition = ->
    return unless $scope.modalMampfMap
    lngLat = { lat: $scope.location.latitude, lng: $scope.location.longitude }
    $scope.modalMampfMap.setCenter(lngLat)
    if $scope.marker
      $scope.marker.setPosition(lngLat)
    else
      $scope.marker = new google.maps.Marker({ position: lngLat, map: $scope.modalMampfMap })

  $scope.$watch 'location', (newValue) ->
    return unless newValue
    sharedData.location = newValue
  #refresh for the first time controller is invoked
  $timeout((-> $scope.refreshPosition()), 500)
]

module.exports = locationDetail
