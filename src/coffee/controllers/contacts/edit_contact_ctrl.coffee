###*
 * @description Contact-Edit-Controller: Edits a contact ...
 *
 * @return {void} No explicit returnvalue needed
###
contactEdit = ['$scope', 'storage', 'sharedData', 'md5', ($scope, storage, sharedData, md5) ->

  $scope.contact = sharedData.contact
  $scope.contacts = storage.get('contacts').filter (contact) ->
    contact.telephone != sharedData.contact.telephone

  $scope.$watch 'contact.telephone', _.debounce((newValue) ->
    return unless newValue
    $scope.$apply ->
      $scope.contact.telephone = newValue.replace(RegExp(" ", "g"), "")
      $scope.contact.telephoneHash = md5.createHash(""+$scope.contact.telephone)
  , 1000)

  $scope.numberExists = ->
    if $scope.contact
      $scope.contacts.reduce(((sum, contact) -> sum || (contact.telephone == $scope.contact.telephone)), false)
    else #initialization has no model (when nothing is typed)
      false
]

module.exports = contactEdit
