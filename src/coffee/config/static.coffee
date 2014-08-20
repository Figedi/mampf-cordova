conf =
  server: "http://141.83.68.32/mampf/"
  dummyContacts: [
    {
      displayName: "dummy"
      selected: false
      telephone: "+4917629322211"
      telephoneHash: "f828ffdfcd8b508cd0a9d16771a55745"
    }
    {
      displayName: "dummy2"
      selected: false
      telephone: "+4917629322212"
      telephoneHash: "2180878ef6bb945692cd66a0c053faf0"
    }
  ]
  dummyLocations: [
    {
      locationName: 'Footown'
      selected: false
      latitude: -6
      longitude: -7
    },
    {
      locationName: 'Bartown'
      selected: false
      latitude: -5
      longitude: -8
    }
  ]

  defaultTimeslots: [
    {
      startTime: "12:00",
      endTime: "14:00"
    }
  ]

  dummyUser:
    telephone: "01522905094913"
    telephoneHash: "d949dd7b976c60f70f6492ee673d6768"
module.exports = conf
