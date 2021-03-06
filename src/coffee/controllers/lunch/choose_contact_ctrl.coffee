###*
 * @description Choose-Contact-Controller: Provides functionality to display all contacts
 * and select them for lunch-planning.
 *
 * @return {void} No explicit returnvalue needed
###
chooseContacts = ['$scope', 'config', 'storage', 'sharedData', ($scope, config, storage, sharedData) ->
  #if user already selected users, return the sharedData object
  if sharedData.contacts.length
    $scope.contactsForChoose = sharedData.contacts
  else #if no prior selection, return a new object
    storage.bind($scope, 'contacts', { defaultValue: config.dummyContacts })
    if $scope.contacts.length
      $scope.contactsForChoose = angular.copy($scope.contacts)
      contact.selected = false for contact in $scope.contactsForChoose

  $scope.toggleContact = (contact) ->
    contact.selected = not contact.selected
    sharedData.contacts = $scope.contactsForChoose

]

module.exports = chooseContacts
