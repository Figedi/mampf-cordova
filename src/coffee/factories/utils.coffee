TIME_FORMAT_OPTONS = ['de', { hour: '2-digit', minute:'2-digit' }]

utils = ['_', (_) ->
  TIME_FORMAT_OPTONS: TIME_FORMAT_OPTONS
  timeSlotConversion: (timeslots) ->
    console.log "timeslots are", timeslots
    tmpDate = new Date()
    dateString = "#{tmpDate.getFullYear()}-#{tmpDate.getMonth()+1}-#{tmpDate.getDate()}"
    timeslots.map (timeslot) ->
      {
        startTime: new Date(Date.parse("#{dateString}, #{timeslot.startTime}")).toISOString()
        endTime: new Date(Date.parse("#{dateString}, #{timeslot.endTime}")).toISOString()
      }
  getCurrentTime: ->
    date = new Date()
    plus2Hours = date.getTime() + 1000 * 60 * 60 * 2
    [
      {
        startTime: date.toLocaleTimeString(TIME_FORMAT_OPTONS...)
        endTime: (new Date(plus2Hours)).toLocaleTimeString(TIME_FORMAT_OPTONS...)
      }
    ]

]
module.exports = utils
