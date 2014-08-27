contacts = [ '$scope', 'sharedData', 'storage', 'config', 'googleContacts', ($scope, sharedData, storage, config, googleContacts) ->

  $scope.contacts = [] #do not inherit from parent scope

  $scope.refreshContacts = ->
    console.log "refreshing contacts"
    googleContacts.getAll().then (contacts) ->
      $scope.contacts = contacts

  $scope.refreshContacts()

  $scope.toggleContact = (contact) ->
    contact.selected = not contact.selected
    sharedData.contacts = $scope.contacts.filter (contact) -> contact.selected



]

module.exports = contacts
