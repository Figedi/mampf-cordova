app = angular.module 'mampfApp', ['onsen.directives', 'ngMd5', 'ui.map', 'angularLocalStorage', 'ui.validate', 'ngTouch']
#app config/statics
constants =
  config : require('./config/static.coffee')
  constants : require('./config/constants.coffee')
  _ : window._ #lodash for DI

app.constant constants

#factories from other files
factories =
  device             : require('./factories/device.coffee')
  cordovaReady       : require('./factories/cordova_ready.coffee')
  contactChooser     : require('./factories/contact_chooser.coffee')
  geoLocation        : require('./factories/geolocation.coffee')
  sharedData         : require('./factories/shared_data.coffee')
  server             : require('./factories/server.coffee')

app.factory factories

#controllers from other files
controllers =
  #contacts (addLocation in ContactList)
  ContactListCtrl    : require('./controllers/contacts/contact_list_ctrl.coffee')
  ContactDetailsCtrl : require('./controllers/contacts/contact_details_ctrl.coffee')

  #locations
  AddLocationCtrl    : require('./controllers/locations/add_location_ctrl.coffee')
  ShowLocationsCtrl  : require('./controllers/locations/show_locations_ctrl.coffee')
  LocationDetailCtrl : require('./controllers/locations/location_detail_ctrl.coffee')

  #lunch
  LunchRequestCtrl   : require('./controllers/lunch/lunch_request_ctrl.coffee')
  LunchResponseCtrl  : require('./controllers/lunch/lunch_response_ctrl.coffee')
  TimeslotCtrl       : require('./controllers/lunch/timeslot_ctrl.coffee')
  ChooseLocationCtrl : require('./controllers/lunch/choose_location_ctrl.coffee')
  ChooseContactCtrl  : require('./controllers/lunch/choose_contact_ctrl.coffee')

  #profile
  ProfileCtrl        : require('./controllers/profile/profile_ctrl.coffee')

app.controller controllers

directives =
  sharedValidate     : require('./directives/shared_validate.coffee')

app.directive directives

#overwrite onsen directive list-item
#
angular.module('onsen').directive 'mampfListItem', require('./directives/ons_list_item.coffee')

# listen to onGoogleReady callback since we are loading the Maps API asynchronously
# after that we can bootstrap the application for the body element
window.onGoogleReady = ->
  console.log "google rdy"
  angular.bootstrap(document.getElementsByTagName('body'), ['mampfApp'])





