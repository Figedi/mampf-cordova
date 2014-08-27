###*
 * @description Profile-Controller, used to save/validate the users' telephone number. After
 * successfull validation, the telephone number is automatically trimmed and
 * a telephonehash is created
 *
 * @return {void} No explicit returnvalue needed
###
profile = ['$scope', 'md5', 'config', '_', 'storage', 'sharedData', ($scope, md5, config, _, storage, sharedData) ->

  # save all user-data in localstorage, bind values to $scope.user
  storage.bind($scope, 'user', { defaultValue: config.dummyUser })
  # bind provider to defaultValue of config, note that angularStorage uses
  # falsy values to detect whether a value is set, thus false/true for providers
  # or 0/1 is a baaad idea
  storage.bind($scope, 'provider', { defaultValue: config.provider.type })
  # instantiate sharedData.user with the localstorage value
  sharedData.user = $scope.user

  # watch for changes in user-model from input. This is only fired,
  # when validation succeeded. After that, generate telephoneHash and trim
  # whitespaces

  $scope.$watch 'user.telephone', _.debounce((newValue) ->
    return unless newValue
    $scope.$apply ->
      $scope.user.telephone = newValue.replace(" ", "")
      $scope.user.telephoneHash = md5.createHash(""+$scope.user.telephone)
      sharedData.user = $scope.user
  , 500)

  $scope.setProvider = (type) -> $scope.provider = type


]

module.exports = profile
