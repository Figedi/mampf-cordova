ctrl = ['$scope', 'contactChooser', 'sharedData', 'storage', 'config', ($scope, contactChooser, sharedData, storage, config) ->

  # bind storage to scope, thus creating two way binding between
  # scope AND localstorage, every scope change is saved in localstorage
  storage.bind($scope, 'contacts', { defaultValue: config.dummyContacts })

  $scope.toggleContact = (contact) ->
    contact.selected = not contact.selected

  $scope.contactAdd = ->
    contactChooser.get().then (results) ->
      $scope.contacts.push(results)
    , (err) ->
      console.log "lol fehler", err
]

module.exports = ctrl
