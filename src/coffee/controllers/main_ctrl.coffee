MainCtrl = ['$scope', 'md5', '_', ($scope, md5, _) ->
  $scope.user =
    email: "bar@foo.com"
    emailHash: ""
  $scope.$watch 'user.email', _.debounce((newValue) ->
    return unless newValue
    $scope.$apply -> $scope.user.emailHash = md5.createHash(newValue)
  , 500)
]

module.exports = MainCtrl
