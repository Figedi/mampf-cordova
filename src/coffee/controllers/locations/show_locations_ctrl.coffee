###*
 * @description Show-location-Controller: Shows all saved locations in a listview, can open a modal
 * dialog for detail view of a location
 *
 * @return {void} No explicit returnvalue needed
###
showLocations = ['$scope', 'config', 'storage', 'sharedData', ($scope, config, storage, sharedData) ->

  storage.bind($scope, 'locations', { defaultValue: config.dummyLocations })

  $scope.showActions = false

  $scope.editLocation = (location) ->
    sharedData.location = location
    ons.navigator.pushPage('partials/locations/locationDetail.html', { animation: "fade" })

  $scope.deleteLocation = ($index) ->
    $scope.locations.splice($index,1)

  #update the scope with new locations if changed when locationpage is popped
  locationsNav.on 'prepop', ->
    $scope.locations = storage.get('locations')
    # if sharedData.locations.length
    #   $scope.locations = sharedData.locations

]

module.exports = showLocations
