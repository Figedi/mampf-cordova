ctrl = ['$scope', 'sharedData', 'storage', 'config', ($scope, sharedData, storage, config) ->
  storage.bind($scope, 'contacts', { defaultValue: config.dummyContacts })
  storage.bind($scope, 'cities', { defaultValue: config.dummyCities })

  $scope.selectedCityName = "Kein Ort ausgewählt"
  $scope.countSelectedContacts = 0
  $scope.startTime = '12:00'
  $scope.endTime = '14:00'

  $scope.getCurrentDateTime = ->
    $scope.startTime = new Date().toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})
    plus2Hours = new Date().getTime() + 1000 * 60 * 60 * 2
    $scope.endTime = (new Date(plus2Hours)).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})

  # set current date
  $scope.getCurrentDateTime()

  $scope.getCount = ->
    $scope.countSelectedContacts = $scope.contacts.filter( (contact) ->contact.selected).length
    return $scope.countSelectedContacts

  $scope.getSelectedCityName = ->
    tmp = city.cityName for city in $scope.cities.filter((city) -> city.selected)
    $scope.selectedCityName = if tmp then tmp else "Kein Ort ausgewählt"
    return $scope.selectedCityName
]
module.exports = ctrl
