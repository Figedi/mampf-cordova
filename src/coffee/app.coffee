app = angular.module 'mampfApp', ['onsen.directives', 'ngTouch', 'ngMd5', 'ui.map', 'angularLocalStorage']
#app config/statics
constants =
  config: require('./config/static.coffee')
  _: window._ #lodash for DI

app.constant constants

#factories from other files
factories =
  device         : require('./factories/device.coffee')
  cordovaReady   : require('./factories/cordova_ready.coffee')
  contactChooser : require('./factories/contact_chooser.coffee')
  geoLocation    : require('./factories/geolocation.coffee')
  sharedData     : require('./factories/shared_data.coffee')

app.factory factories

#controllers from other files
controllers =
  MainCtrl        : require('./controllers/main_ctrl.coffee')
  ContactCtrl     : require('./controllers/contact_ctrl.coffee')
  MapsCtrl        : require('./controllers/maps_ctrl.coffee')
  LunchController : require('./controllers/lunch_ctrl.coffee')

app.controller controllers

window.onGoogleReady = ->
  console.log("google is ready")
  angular.bootstrap(document.getElementsByTagName('body'), ['mampfApp'])





