contactAdd = ['$scope', 'sharedData', 'storage', 'config', 'md5', ($scope, sharedData, storage, config, md5) ->

  storage.bind($scope, 'contacts')

  $scope.numberExists = ->
    if $scope.contact
      $scope.contacts.reduce(((sum, contact) -> sum || (contact.telephone == $scope.contact.telephone)), false)
    else #initialization has no model (when nothing is typed)
      false


  $scope.addNewContact = ->
    $scope.contact.telephone = $scope.contact.telephone.replace(RegExp(" ", "g"), "")
    contact =
      displayName: $scope.contact.displayName
      selected: false
      telephone: $scope.contact.telephone
      telephoneHash: md5.createHash(""+$scope.contact.telephone)

    $scope.contacts.push(contact)
    storage.set('contacts', $scope.contacts)

]

module.exports = contactAdd
