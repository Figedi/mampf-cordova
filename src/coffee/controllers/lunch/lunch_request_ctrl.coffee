###*
 * @description Lunch-Request-Controller: Provides the functionality to set multiple lunch-times and
 * links to choose-location/-contact Pages to select those.
 * After successfull selection of all neccessary data, it can fire a request
 * to the server and redirect to the Lunch-Reponse-Controller
 *
 * @todo  strip old code
 *
 * @return {void} No explicit returnvalue needed
###
lunchRequest = ['server', '$scope', 'sharedData', 'storage', 'config', 'constants', 'geoLocation', '$q', '$rootScope', (server, $scope, sharedData, storage, config, constants, geoLocation, $q, $rootScope) ->

  storage.bind($scope, 'user')

  # data binding doesnt seem to work without a request data model

  $scope.getCount = ->
    sharedData.contacts.filter((contact) -> contact.selected).length

  $scope.requestNotReady = ->
    $scope.getCount() == 0 || !$scope.isUserPropertiesDefined() ||
      $scope.getSelectedLocationName() == null || typeof sharedData.timeslots == 'undefined'


  $scope.isUserPropertiesDefined = ->
    typeof $scope.user != 'undefined' &&
      typeof $scope.user.telephone != 'undefined' &&
        typeof $scope.user.telephoneHash != 'undefined'

  $scope.getSelectedLocationName = ->
    [type, location] = _getLocationType()
    switch type
      when constants.USE_PREDEFINED_LOCATION
        if location.length then location[0].locationName else null
      when constants.USE_GPS_LOCATION
        "Aktuelle Position ermitteln"
      when constants.LOCATION_NOT_SET
        null
      else
        null

  pushPage = (pageSuffix) ->
    pagePath = 'partials/lunch/' + pageSuffix
    sharedData.location = location
    ons.navigator.pushPage(pagePath, { animation: "slide" })

  ###$scope.sendRequest = (inputdata) ->
    $http({
      method: 'POST',
      url:"#{config.server}",
      data: JSON.stringify(inputdata, null, '  ')
    })###

  $scope.doRequest = ->
    # first, fetch invitees' hashes
    inviteeHashes = sharedData.contacts.filter((contact) -> contact.selected).map((contact) -> contact.telephoneHash)
    # second, fetch the own users md5
    telephoneHash = $scope.user.telephoneHash
    # third either fetch the current position or use predefined destination
    _getLocation().then (coords) ->
      request =
        identity: telephoneHash
        invitees: inviteeHashes
        currentPosition: coords
        timeslots: sharedData.timeslots
      #$scope.sendRequest(request).then (response) ->
      server.send(request).then (response) ->
        if response.data.subjects.length == 0
          sharedData.responseErrorId = constants.ERROR_BY_NO_MATCH
          pushPage("showResultsFailurePage.html")
        else
          sharedData.responseData = angular.copy(response.data)
          sharedData.responseErrorId = constants.NO_ERROR
          pushPage("showResultsSuccessPage.html")
      , (error) ->
        sharedData.responseErrorId = constants.ERROR_BY_NO_SERVER_RESPONSE
        sharedData.responseError = angular.copy(error)
        pushPage("showResultsFailurePage.html")
    , (error) ->
      sharedData.responseErrorId = constants.ERROR_BY_RETRIEVING_POSITION
      sharedData.responseError = angular.copy(error)
      pushPage("showResultsFailurePage.html")


  # determines current selected type, can be either location or GPS
  _getLocationType = ->
    selectedLocation = sharedData.locations.filter((location) -> location.selected)
    if selectedLocation.length
      [constants.USE_PREDEFINED_LOCATION, selectedLocation]
    else if sharedData.positionLocation
      [constants.USE_GPS_LOCATION, null]
    else
      [constants.LOCATION_NOT_SET, null]

  # Helper method to fetch current position or predefined location
  # @todo: Statics for reject
  _getLocation = ->
    deferred = $q.defer()
    [type, location] = _getLocationType()
    switch type
      when constants.USE_PREDEFINED_LOCATION
        if location.length
          deferred.resolve({longitude: location[0].longitude, latitude: location[0].latitude})
        else
          deferred.reject()

      when constants.USE_GPS_LOCATION
        geoLocation.getPosition().then (position) ->
          deferred.resolve({ latitude: position.coords.latitude, longitude: position.coords.longitude })
        , (error) ->
          deferred.reject()
      when constants.LOCATION_NOT_SET
        deferred.reject()
      else
        deferred.reject()
    deferred.promise

]
module.exports = lunchRequest
