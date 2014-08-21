lunchResponse = ['$http', '$scope', 'sharedData', 'storage', 'config', 'constants', 'geoLocation', '$q', '$rootScope', ($http, $scope, sharedData, storage, config, constants, geoLocation, $q, $rootScope) ->

  $scope.setTitle = ->
    switch sharedData.responseErrorId
      when constants.ERROR_BY_RETRIEVING_POSITION
        "Fehler beim Abfragen der aktuellen Position"
      when constants.ERROR_BY_NO_SERVER_RESPONSE
        "Fehler - Keine Antwort vom Server. Fehlercode: #{sharedData.responseError.status}"
      when constants.ERROR_BY_NO_MATCH
        "Fehler - Keine treffende Übereinstimmung"
      when constants.NO_ERROR
        "Erfolgreiche Suche"

  $scope.getContacts = ->
    selectedContacts = []
    telephoneHashes = []
    telephoneHashes.push(sharedData.responseData.subjects)

    console.log telephoneHashes
    for contact in sharedData.contacts.filter( (contact) -> contact.selected )
      console.log contact
      selectedContacts.push(contact) if contact.telephoneHash in telephoneHashes
    console.log selectedContacts
]

module.exports = lunchResponse
