ctrl = ['$scope', 'contactChooser', ($scope, contactChooser) ->
  $scope.contacts = [
    {
      displayName: "dummy"
    }
  ]
  $scope.contactAdd = ->
    contactChooser.get().then (results) ->
      $scope.contacts.push(results)
    , (err) ->
      console.log "lol fehler", err
]

module.exports = ctrl
