###*
 * @description Contact-List-Controller: Shows all saved/imported contacts in a list with
 * the ability to open a modal/page for contact's details.
 *
 * To import new contacts, the user can add them through cordova's contacts API
 *
 * @todo Add new Provider for Contacts when cordova API not available or errors
 * thrown during contact import. This can be done with the google contacts API
 * since most of the users are using android, we can rely on contact-syncing
 * from android to google. This has some downsides, since the contact api needs
 * Oauth(2), which needs a redirection uri, so we need to host it somewhere
 *
 * OR: Use http://oauth.io with free plan (1000users/month)
 *
 * @todo strip old code
 *
 * @return {void} No explicit returnvalue needed
###
contactsList = ['$scope', 'contactChooser', 'sharedData', 'storage', 'config', 'md5', '_', ($scope, contactChooser, sharedData, storage, config, md5, _) ->

  # bind storage to scope, thus creating two way binding between
  # scope AND localstorage, every scope change is saved in localstorage
  storage.bind($scope, 'contacts', { defaultValue: config.dummyContacts })

  $scope.toggleContact = (contact) ->
    contact.selected = not contact.selected
    sharedData.contacts = $scope.contacts

  $scope.deleteContact = ($index) ->
    $scope.contacts.splice($index,1)

  $scope.isSmartphone = ->
    navigator.userAgent.match(/(iPhone|iPod|iPad|Android|BlackBerry|IEMobile)/)

  $scope.editContact = ($event, contact) ->
    sharedData.contact = contact
    contactsNav.pushPage('partials/contacts/edit_contact.html', { animation: 'fade' })

  $scope.contactAdd = ->
    contactsProvider = storage.get('provider') || config.provider.type
    contactsProvider = 'manual' unless $scope.isSmartphone()

    if contactsProvider == 'local'
      contactChooser.get().then (contact) ->
        #contactchoose returns always ONE contact
        if contact.phoneNumbers.length && (t = contact.phoneNumbers[1].value).trim()
          if not t.test(/^\+49\s*/) && t.test(/^0\s*/)
            t = t.replace(/0/, "+49") # since js's replace just replaces the first occurence of "0"
            tHash = md5.createHash(""+t)
        contact =
          displayName: contact.displayName
          telephone: t
          telephoneHash: tHash
          selected: false
        if $scope.contacts.filter((contact) -> contact.telephone == t).length == 0
          $scope.contacts.push(contact)
        #if sharedData has been used already, push new contact in it
          if sharedData.contacts.length
            sharedData.contacts.push(contact)
      , (err) ->
        console.log "lol fehler", err
    else if contactsProvider == 'contacts'
      contactsNav.pushPage('partials/contacts/google_contacts.html')
    else if contactsProvider == 'manual'
      contactsNav.pushPage('partials/contacts/add_new_contact.html')

    #update the scope with new contacts if changed when contactpage is popped
    contactsNav.on 'prepop', ->
      oldContacts = _.map angular.copy($scope.contacts), (contact) -> contact.telephone
      $scope.contacts = storage.get('contacts')
      #if sharedData has already preselected contacts, push new one onto it
      if sharedData.contacts.length
        difference = _.reject $scope.contacts, (contact) ->
          contact.telephone in oldContacts
        for contact in difference
          sharedData.contacts.push(contact)

]

module.exports = contactsList
