###*
 * @description Choose-Location-Controller: Provides functionality to display all locations
 * and select one of them for lunch-planning.
 *
 * @return {void} No explicit returnvalue needed
###
chooseLocation = ['$scope', 'config', 'storage', 'sharedData', ($scope, config, storage, sharedData) ->

  $scope.positionLocation = sharedData.positionLocation || false

  #if user already selected users, return the sharedData object
  if sharedData.locations.length
    $scope.locationsForChoose = sharedData.locations
  else #if no prior selection, return a new object
    storage.bind($scope, 'locations', { defaultValue: config.dummyLocations })
    if $scope.locations
      console.log "it works"
      $scope.locationsForChoose = angular.copy($scope.locations)
      location.selected = false for location in $scope.locationsForChoose

  $scope.toggleLocation = (location) ->
    $scope.positionLocation = false
    c.selected = false for c in $scope.locationsForChoose
    location.selected = not location.selected
    sharedData.locations = $scope.locationsForChoose

  $scope.setLocationPosition = ->
    if $scope.locationsForChoose
      c.selected = false for c in $scope.locationsForChoose
    $scope.positionLocation = not $scope.positionLocation
    sharedData.positionLocation = $scope.positionLocation
]

module.exports = chooseLocation
