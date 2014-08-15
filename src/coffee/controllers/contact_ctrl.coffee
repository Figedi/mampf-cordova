ctrl = ['$scope', 'contactChooser', 'sharedData', ($scope, contactChooser, sharedData) ->
  $scope.contacts = [
    {
      displayName: "dummy"
      selected: false
    },
    {
      displayName: "dummy2"
      selected: false
    }
  ]

  $scope.$watch 'contacts', (newEntry) ->
    console.log "new contact change", newEntry

  $scope.toggleContact = (contact) ->
    contact.selected = not contact.selected
    #use $digest since toggleContact is called in a DOM event ('click in directive')
    $scope.$digest()


  $scope.contactAdd = ->
    contactChooser.get().then (results) ->
      $scope.contacts.push(results)
    , (err) ->
      console.log "lol fehler", err
]

module.exports = ctrl
