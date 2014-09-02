
timeslotsctrl = ['$scope', 'config', 'storage', 'sharedData', 'utils', ($scope, config, storage, sharedData, utils) ->

  storage.bind($scope, 'timeslots')
  #default value for timeslots
  $scope.timeslots = [{ startTime: '', endTime: ''}]

  $scope.validateTime = (date1, date2) ->
    parseInt(date1.replace(":","")) <= parseInt(date2.replace(":",""))

  $scope.setDateTime = (id) ->
    if storage.get('timeslots') && storage.get('timeslots')[id]
      console.log "we are here"
      _ = storage.get('timeslots')[id]

      tmpDate = new Date()
      dateString = "#{tmpDate.getFullYear()}-#{tmpDate.getMonth()+1}-#{tmpDate.getDate()}"
      console.log "datestring", dateString, _.startTime, _.endTime
      $scope.timeslots[id].startTime = new Date(Date.parse("#{dateString}, #{_.startTime}")).toLocaleTimeString(utils.TIME_FORMAT_OPTONS...)
      $scope.timeslots[id].endTime= new Date(Date.parse("#{dateString}, #{_.endTime}")).toLocaleTimeString(utils.TIME_FORMAT_OPTONS...)
    else
      currentTime = utils.getCurrentTime()
      console.log "currentTime is", currentTime, id, $scope.timeslots
      $scope.timeslots[id].startTime = currentTime[0].startTime
      $scope.timeslots[id].endTime = currentTime[0].endTime

  # set current date
  $scope.setDateTime(0)

  $scope.addTimeSlot = ->
    nextID = $scope.timeslots.length
    $scope.timeslots.push
      startTime: ""
      endTime: ""

    $scope.setDateTime(nextID)
    _setSharedTimeslotData()

  $scope.removeTimeSlot = ($index) ->
    return unless $index > 0
    $scope.timeslots.splice($index,1)
    _setSharedTimeslotData()

  _setSharedTimeslotData = ->
    sharedData.timeslots = utils.timeSlotConversion($scope.timeslots)

  _setSharedTimeslotData()

  $scope.saveTimeSlots = ->
    _setSharedTimeslotData()
]

module.exports = timeslotsctrl
