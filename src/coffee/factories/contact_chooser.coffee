contact = [ '$q', ($q) ->

  _get = ->
    deferred = $q.defer()
    navigator.contacts.pickContact (contact) ->
      deferred.resolve(contact)
    , (err) ->
      deferred.reject(err)
    deferred.promise

  {
    get: _get
  }
]
module.exports = contact
