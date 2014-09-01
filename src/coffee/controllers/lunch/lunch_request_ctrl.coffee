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
lunchRequest = ['server', '$scope', 'sharedData', 'storage', 'config', 'constants', 'geoLocation', '$q', (server, $scope, sharedData, storage, config, constants, geoLocation, $q) ->

  storage.bind($scope, 'user')
  storage.bind($scope, 'timeslots')

  $scope.requestSent = false
  # data binding doesnt seem to work without a request data model

  $scope.getCount = ->
    sharedData.contacts.filter((contact) -> contact.selected).length

  $scope.requestNotReady = ->
    $scope.getCount() == 0 || !$scope.isUserPropertiesDefined() ||
      $scope.getSelectedLocationName() == null || typeof sharedData.timeslots == 'undefined'

  $scope.openModal = (errorCode) ->
    switch errorCode
      when constants.ERROR_BY_NO_MATCH
        $scope.failureReason = "Keine übereinstimmende Anfrage!"
      when constants.ERROR_BY_NO_SERVER_RESPONSE
        $scope.failureReason = "Server antwortet nicht!"
      when constants.ERROR_BY_RETRIEVING_POSITION
        $scope.failureReason = "Aktuelle Position nicht ermittelbar!"
      else
        $scope.failureReason = "Unbekannter Fehler"
    failureModal.show()

  $scope.isUserPropertiesDefined = -> $scope.user?.telephone? && $scope.user.telephoneHash?

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

  $scope.getSelectedTimes = ->
    if sharedData.timeslots?
      sharedData.timeslots.length
    else if $scope.timeslots?.length
      $scope.timeslots?.length
    else
      "Keine"

  pushPage = (pageSuffix) ->
    pagePath = 'partials/lunch/' + pageSuffix
    sharedData.location = location
    ons.navigator.pushPage(pagePath, { animation: "slide" })

  sanitizeTimeslots = ->
    _.unique sharedData.timeslots, (date) ->
      start = +new Date(Date.parse(date.startTime))
      end = +new Date(Date.parse(date.endTime))
      "#{start}:#{end}"


  $scope.doRequest = ->

    $scope.requestSent = true
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
        timeslots: sanitizeTimeslots()
      console.log "timeslots", request.timeslots
      server.send(request).then (response) ->
        if response.data.subjects.length == 0
          sharedData.responseErrorId = constants.ERROR_BY_NO_MATCH
          $scope.openModal(constants.ERROR_BY_NO_MATCH)
        else
          sharedData.responseData = angular.copy(response.data)
          console.log "sharedData is", sharedData.responseData
          sharedData.responseErrorId = constants.NO_ERROR
          pushPage("showResultsSuccessPage.html")
        $scope.requestSent = false
      , (error) ->
        sharedData.responseErrorId = constants.ERROR_BY_NO_SERVER_RESPONSE
        sharedData.responseError = angular.copy(error)
        #pushPage("showResultsFailurePage.html")
        $scope.openModal(constants.ERROR_BY_NO_SERVER_RESPONSE)
        $scope.requestSent = false
    , (error) ->
      sharedData.responseErrorId = constants.ERROR_BY_RETRIEVING_POSITION
      sharedData.responseError = angular.copy(error)
      #pushPage("showResultsFailurePage.html")
      $scope.openModal(constants.ERROR_BY_RETRIEVING_POSITION)
      $scope.requestSent = false


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
