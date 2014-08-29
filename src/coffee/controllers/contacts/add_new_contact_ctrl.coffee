contactAdd = ['$scope', 'sharedData', 'storage', 'config', 'md5', ($scope, sharedData, storage, config, md5) ->

  $scope.contacts = storage.get('contacts')

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

    sharedData.contacts = [contact]

]

module.exports = contactAdd
