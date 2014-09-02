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

  $scope.deleteLocation = ($index, location) ->
    if sharedData.locations.length
      _.remove sharedData.locations, (sharedLocation) ->
        sharedLocation.createdAt == location.createdAt
    $scope.locations.splice($index,1)

  #update the scope with new locations if changed when locationpage is popped
  locationsNav.on 'prepop', ($event) ->
    #when we edited the page, we probably need to update sharedData
    if $event.currentPage.name == "partials/locations/locationDetail.html"
      #update the location in sharedData (if any)
      if sharedData.locations.length
        l = sharedData.location
        sharedData.locations = _.map sharedData.locations, (location) ->
          #if object is in sharedData, change selected attribute for it
          if location.createdAt == l.createdAt
            l.selected = location.selected
            l
          else
            location
      $scope.locations = storage.get('locations')
      sharedData.$wipe('location')
    #else addLocation
    else
      $scope.locations = storage.get('locations')
      if sharedData.locations.length
        sharedData.locations.push(sharedData.location)
        sharedData.$wipe('location')


]

module.exports = showLocations
