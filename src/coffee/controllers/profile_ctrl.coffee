ProfileCtrl = ['$scope', 'md5', 'config', '_', 'storage', 'sharedData', ($scope, md5, config, _, storage, sharedData) ->

  storage.bind($scope, 'user', { defaultValue: config.dummyUser })
  sharedData.user = $scope.user

  $scope.$watch 'user.telephone', _.debounce((newValue) ->
    return unless newValue
    $scope.$apply ->
      $scope.user.telephone = newValue.replace(" ", "")
      $scope.user.telephoneHash = md5.createHash(""+$scope.user.telephone)
      sharedData.user = $scope.user
  , 500)
]

module.exports = ProfileCtrl
