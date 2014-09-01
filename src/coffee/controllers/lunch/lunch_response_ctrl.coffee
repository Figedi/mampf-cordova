lunchResponse = ['$scope', 'sharedData', 'config', 'constants', ($scope, sharedData, config, constants) ->

  $scope.selectedContacts = []

  $scope.setTitle = ->
    switch sharedData.responseErrorId
      when constants.NO_ERROR
        "Erfolgreiche Suche"
      else
        "Fehlerbehaftete Suche"

  $scope.setContacts = ->
    return unless sharedData.responseErrorId == constants.NO_ERROR
    $scope.selectedContacts = sharedData.contacts.filter (contact) ->
      contact.telephoneHash in sharedData.responseData.subjects

  # set selected contacts
  $scope.setContacts()

  $scope.getEnd = ->
    date = new Date(sharedData.responseData.timeslot.endTime)
    date.toLocaleTimeString('de', { hour: '2-digit', minute:'2-digit' })

  $scope.getStart = ->
    date = new Date(sharedData.responseData.timeslot.startTime)
    date.toLocaleTimeString('de', { hour: '2-digit', minute:'2-digit' })
]

module.exports = lunchResponse
