app = angular.module 'mampfApp', ['onsen.directives', 'ngTouch', 'ngMd5']
#app config/statics
constants =
  config: require('./config/static.coffee')
  _: window._ #lodash for DI

app.constant constants
#controllers from other files
controllers =
  MainCtrl: require('./controllers/main_ctrl.coffee')
  ContactController: require('./controllers/contact_ctrl.coffee')

app.controller controllers
#factories from other files
factories =
  device:       require('./factories/device.coffee')
  cordovaReady: require('./factories/cordova_ready.coffee')

app.factory factories





