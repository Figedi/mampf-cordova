ctrl = ['$scope', 'contactChooser', 'sharedData', 'storage', 'config', 'md5', ($scope, contactChooser, sharedData, storage, config, md5) ->

  # bind storage to scope, thus creating two way binding between
  # scope AND localstorage, every scope change is saved in localstorage
  storage.bind($scope, 'contacts', { defaultValue: config.dummyContacts })

  $scope.toggleContact = (contact) ->
    contact.selected = not contact.selected
    sharedData.contacts = $scope.contacts

  $scope.contactAdd = ->
    contactChooser.get().then (contact) ->
      #contact contains always ONE contact
      console.log "contact", contact, contact.phoneNumbers.value
      #contact.phoneNumbers
      if contact.phoneNumbers && (t = contact.phoneNumbers[1].value).trim()
        t = t.replace(/^\+49\s*/, 0)
        tHash = md5.createHash(""+t)
      contact =
        displayName: contact.displayName
        telephone: t
        telephoneHash: tHash
        selected: false
      console.log "contact after", contact
      $scope.contacts.push(contact)
    , (err) ->
      console.log "lol fehler", err
]

module.exports = ctrl
