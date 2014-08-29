contactAdd = ['$scope', 'sharedData', 'storage', 'config', 'md5', ($scope, sharedData, storage, config, md5) ->

  storage.bind($scope, 'contacts', { defaultValue: config.dummyContacts })
  sharedData.contacts = $scope.contacts #alias sharedData.contacts with current scope

  $scope.addNewContact = ->
    contact =
      displayName: $scope.contact.displayName
      selected: false
      telephone: $scope.contact.telephone
      telephoneHash: md5.createHash(""+$scope.contact.telephone)

    if $scope.contacts.filter((contact) -> contact.telephone == $scope.contact.telephone).length == 0
      $scope.contacts.push(contact)
      storage.set('contacts', $scope.contacts)
      #if sharedData has been used already, push new contact in it
      #if sharedData.contacts.length
      #  sharedData.contacts.push(contact)
]

module.exports = contactAdd
