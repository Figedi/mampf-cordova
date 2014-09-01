contacts = [ '$scope', 'sharedData', 'storage', 'config', 'googleContacts', '_', ($scope, sharedData, storage, config, googleContacts, _) ->

  $scope.googleContacts = [] #do not inherit from parent scope
  originalContacts = storage.get('contacts')
  $scope.refreshContacts = ->
    googleContacts.getAll().then (contacts) ->
      $scope.googleContacts = contacts

  $scope.refreshContacts()

  $scope.toggleContact = (contact) ->
    contact.selected = not contact.selected
    contacts = angular.copy(originalContacts)
    selectedContacts = $scope.googleContacts.filter (contact) -> contact.selected
    mergedContacts = contacts.concat(selectedContacts)
    storage.set('contacts', mergedContacts)

]

module.exports = contacts
