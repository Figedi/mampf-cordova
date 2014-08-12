MainCtrl = ['$scope', 'device', ($scope, device) ->
  $scope.foo = "bar"
  $scope.spinMe = true
  $scope.onSpinClick = ->
    console.log "it works"
    $scope.spinMe = not $scope.spinMe
]

module.exports = MainCtrl
