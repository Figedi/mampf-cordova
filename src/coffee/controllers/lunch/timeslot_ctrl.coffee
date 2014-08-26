timeslotsctrl = ['$scope', 'config', 'storage', 'sharedData', ($scope, config, storage, sharedData) ->

  storage.bind($scope, 'timeslots', { defaultValue: config.defaultTimeslots })

  $scope.validateTime = (value1,value2) ->
    value1 <= value2

  $scope.setDateTime = (id)->
    date = new Date()
    # anstelle von toLocaleTimeString(navigator.language, lieber de nutzen für deutsche Ausgabe
    $scope.timeslots[id].startTime = date.toLocaleTimeString('de', {hour: '2-digit', minute:'2-digit'})
    plus2Hours = date.getTime() + 1000 * 60 * 60 * 2
    $scope.timeslots[id].endTime = (new Date(plus2Hours)).toLocaleTimeString('de', {hour: '2-digit', minute:'2-digit'})

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
    _setSharedTimeslotData()

  _setSharedTimeslotData = ->
    tmpDate = new Date()
    dateString = "#{tmpDate.getFullYear()}-#{tmpDate.getMonth()+1}-#{tmpDate.getDate()}"
    isoTimeSlot = angular.copy($scope.timeslots)
    isoTimeSlot = isoTimeSlot.map ( (timeslot) ->
        {
          startTime: new Date(Date.parse("#{dateString}, #{timeslot.startTime}")).toISOString()
          endTime: new Date(Date.parse("#{dateString}, #{timeslot.endTime}")).toISOString()
        }
      )
    sharedData.timeslots = isoTimeSlot

  _setSharedTimeslotData()

  $scope.saveTimeSlots = () ->
    _setSharedTimeslotData()
]

module.exports = timeslotsctrl
