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
lunchRequest = ['$scope', 'sharedData', 'storage', 'config', 'constants', 'geoLocation', 'server', '$q', ($scope, sharedData, storage, config, constants, geoLocation, server, $q) ->

  storage.bind($scope, 'user')

  $scope.getCurrentDateTime = ->
    $scope.startTime = new Date().toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})
    plus2Hours = new Date().getTime() + 1000 * 60 * 60 * 2
    $scope.endTime = (new Date(plus2Hours)).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})

  # set current date
  $scope.getCurrentDateTime()

  $scope.getCount = ->
    sharedData.contacts.filter((contact) -> contact.selected).length

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

  $scope.doRequest = ->
    # first format dates according to API specification
    tmpDate = new Date()
    dateString = "#{tmpDate.getFullYear()}-#{tmpDate.getMonth()+1}-#{tmpDate.getDate()}"
    startTime = new Date(Date.parse("#{dateString}, #{$scope.startTime}")).toISOString()
    endTime = new Date(Date.parse("#{dateString}, #{$scope.endTime}")).toISOString()
    # second, fetch invitees' hashes
    inviteeHashes = sharedData.contacts.filter((contact) -> contact.selected).map((contact) -> contact.telephoneHash)
    # third, fetch the own users md5
    telephoneHash = $scope.user.telephoneHash

    # either fetch the current position or use predefined destination
    _getLocation().then (coords) ->

      request =
      identity: telephoneHash
      invitees: inviteeHashes
      currentPosition: coords
      timeSlots: [ #for testing reasons only one allowed
        {
          startTime: startTime
          endTime: endTime
        }
      ]
      server.create({data: request }).then (response) ->
        console.log "we have a response", response
    , (error) ->
      console.log "oops error while retrieving coordinates"

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
