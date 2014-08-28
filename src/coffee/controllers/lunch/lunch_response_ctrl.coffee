lunchResponse = ['$http', '$scope', 'sharedData', 'storage', 'config', 'constants', 'geoLocation', '$q', '$rootScope', ($http, $scope, sharedData, storage, config, constants, geoLocation, $q, $rootScope) ->

  $scope.responseData = angular.copy(sharedData.responseData)

  $scope.setTitle = ->
    switch sharedData.responseErrorId
      when constants.NO_ERROR
        "Erfolgreiche Suche"
      else
        "Fehlerbehaftete Suche"

  $scope.setContacts = ->
    $scope.selectedContacts = []

    return unless sharedData.responseErrorId == constants.NO_ERROR

    for contact in sharedData.contacts.filter( (contact) -> contact.selected )
      $scope.selectedContacts.push(contact) if contact.telephoneHash in $scope.responseData.subjects

  # set selected contacts
  $scope.setContacts()

  $scope.getEnd = ->
    date = new Date(sharedData.responseData.timeslot.endTime)
    date.toLocaleTimeString('de', {hour: '2-digit', minute:'2-digit'})

  $scope.getStart = ->
    date = new Date(sharedData.responseData.timeslot.startTime)
    date.toLocaleTimeString('de', {hour: '2-digit', minute:'2-digit'})
]

module.exports = lunchResponse
