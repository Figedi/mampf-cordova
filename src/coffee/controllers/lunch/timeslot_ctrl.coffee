timeslotsctrl = ['$scope', 'config', 'storage', 'sharedData', ($scope, config, storage, sharedData) ->

  storage.bind($scope, 'timeslots', { defaultValue: config.defaultTimeslots })

  $scope.validateTime = (value1,value2) ->
    value1 <= value2

  $scope.setDateTime = (id)->
    date = new Date()
    $scope.timeslots[id].startTime = date.toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})
    plus2Hours = date.getTime() + 1000 * 60 * 60 * 2
    $scope.timeslots[id].endTime = (new Date(plus2Hours)).toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'})

  # set current date
  $scope.setDateTime(0)

  $scope.addTimeSlot = () ->
    nextID = $scope.timeslots.length
    $scope.timeslots.push(
        startTime: ""
        endTime: ""
      )
    $scope.setDateTime(nextID)

  $scope.removeTimeSlot = ($index) ->
    $scope.timeslots.splice($index,1)

  $scope.saveTimeSlots = () ->
    sharedData.timeslots = $scope.timeslots
]

module.exports = timeslotsctrl
