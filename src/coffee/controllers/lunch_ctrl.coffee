ctrl = ['$scope', 'sharedData', 'storage', 'config', 'geoLocation', 'server', ($scope, sharedData, storage, config, geoLocation, server) ->

  storage.bind($scope, 'user')

  $scope.getCurrentDateTime = ->
    $scope.startTime = new Date().toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})
    plus2Hours = new Date().getTime() + 1000 * 60 * 60 * 2
    $scope.endTime = (new Date(plus2Hours)).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})

  # set current date
  $scope.getCurrentDateTime()

  $scope.getCount = ->
    sharedData.contacts.filter((contact) -> contact.selected).length

  $scope.getSelectedCityName = ->
    selectedCity = sharedData.cities.filter((city) -> city.selected)
    if selectedCity.length then selectedCity[0].cityName else null


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

    selectedCity = sharedData.cities.filter((city) -> city.selected) #if none selected use current position
    if selectedCity.length
      request =
        identity: telephoneHash
        invitees: inviteeHashes
        currentPosition:
          longitude: selectedCity[0].longitude
          latitude: selectedCity[0].latitude
        timeSlots: [ #for testing reasons only one allowed
          {
            startTime: startTime
            endTime: endTime
          }
        ]

      console.log "reqzest is", request
      server.create({url: "mampf", data: request }).then (response) ->
        console.log "we have a response", response
    #geoLocation.getPosition().then (position) ->
    #  lngLat = { latitude: position.coords.latitude, longitude: position.coords.longitude }

]
module.exports = ctrl
