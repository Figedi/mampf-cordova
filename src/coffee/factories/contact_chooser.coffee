contact = ['$window', '$timeout', '$q', ($window, $timeout, $q) ->
  _get = ->
    deferred = $q.defer()
    navigator.contacts.pickContact (contact) ->
      deferred.resolve(contact)
    , (err) ->
      deferred.reject(err)
    # $window.plugins.ContactChooser.chooseContact (contactInfo) ->
    #   $timeout ->
    #     deferred.resolve(contactInfo)
    #   , 0
    deferred.promise

  {
    get: _get #-> _get()
  }
]
module.exports = contact
