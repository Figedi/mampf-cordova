###*
 * @todo  eigenen controller/view für contacts
 *
 * @param {[type]} $window  [description]
 * @param {[type]} $timeout [description]
 * @param {[type]} $q       [description]
 * @param {[type]} storage  [description]
 * @param {[type]} config   [description]
 * @param {[type]} $http    [description]
 *
 * @return {[type]} [description]
###
contacts = ['$q', '$http', '$window', ($q, $http, $window) ->

  $window.OAuth.initialize('29UtB1-Grz7cpdH4TVjcq0pg8ws')

  access_token = null

  authenticate = ->
    deferred = $q.defer()
    $window.OAuth.popup('google_contact', { cache: true })
    .done (response) ->
      deferred.resolve(response)
    .fail (error) ->
      deferred.reject(error)
    deferred.promise

  getToken = ->
    deferred = $q.defer()
    if access_token
      deferred.resolve(access_token)
    else
      authenticate().then (response) ->
        access_token = response.access_token
        deferred.resolve(access_token)
    deferred.promise

  {
    getAll: ->
      deferred = $q.defer()
      getToken().then (access_token) ->
        $http.get("https://www.google.com/m8/feeds/contacts/default/full?access_token=#{access_token}&alt=json&max-results=500")
        .success (data) ->
          console.log "data is ", data
          data = for element in data.feed.entry
            if element.gd$phoneNumber?.length && element.title?.$t?
              {
                displayName: element.title.$t
                selected: false
                telephone: element.gd$phoneNumber[0].$t
                telephoneHash: "todo"
              }
            else
              continue
          console.log "data is now", data
          deferred.resolve(data)
        .error (error) -> deferred.reject(error)
      deferred.promise
  }
]
module.exports = contacts
