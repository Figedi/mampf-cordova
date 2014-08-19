timeslotsctrl = ['$scope', 'config', 'storage', 'sharedData', ($scope, config, storage, sharedData) ->

  storage.bind($scope, 'timeslots', { defaultValue: config.dummyTimeslots })

  $scope.foo = "test"

  $scope.lastId = $scope.timeslots.length-1;

  $scope.request =
    startTime: "12:00"
    endTime: "14:00"

  $scope.validate = (value1,value2) ->
    value1 <= value2

  $scope.getCurrentDateTime = ->
    $scope.request.startTime = new Date().toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})
    plus2Hours = new Date().getTime() + 1000 * 60 * 60 * 2
    $scope.request.endTime = (new Date(plus2Hours)).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})

  # set current date
  $scope.getCurrentDateTime()

  $scope.addTimeSlots = () ->
    console.log "todo"
    true
]

module.exports = timeslotsctrl
