ContactController = ['$scope', 'device', ($scope, device) ->
	$scope.contactSelected = false
	$scope.modifierStyle = 'light'
	$scope.toggleChooseContact = ->
		$scope.modifierStyle = if $scope.contactSelected then 'normal' else 'light'
		$scope.contactSelected = not $scope.contactSelected
]

module.exports = ContactController