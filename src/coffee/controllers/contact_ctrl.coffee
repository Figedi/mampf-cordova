ContactController = ['$scope', 'device', ($scope, device) ->
  $scope.contactSelected = false
  $scope.modifierStyle = 'light'
  $scope.toggleChooseContact = ->
  	$scope.modifierStyle = $scope.contactSelected ? 'normal' : 'light'
    $scope.contactSelected = not $scope.contactSelected
]

module.exports = ContactController
