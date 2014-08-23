###*
 * @description Show-location-Controller: Shows all saved locations in a listview, can open a modal
 * dialog for detail view of a location
 *
 * @return {void} No explicit returnvalue needed
###
showLocations = ['$scope', 'config', 'storage', 'sharedData', ($scope, config, storage, sharedData) ->
  storage.bind($scope, 'locations', { defaultValue: config.dummyLocations })

  $scope.showActions = false;

  $scope.editLocation = (location) ->
    sharedData.location = location
    ons.navigator.pushPage('partials/profile/locationDetail.html', { animation: "fade" })

  $scope.deleteAllSelected = ->
    $scope.deleteLocation(location) for location in $scope.locations.filter((location) -> location.selected)

  $scope.deleteLocation = ($index) ->
    $scope.locations.splice($index,1)
]

module.exports = showLocations
