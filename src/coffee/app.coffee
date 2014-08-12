app = angular.module 'mampfApp', ['onsen.directives', 'ngTouch']

#controllers from other files
controllers =
  MainCtrl: require('./controllers/main_ctrl.coffee')

app.controller controllers

#factories from other files

factories =
  device:       require('./factories/device.coffee')
  cordovaReady: require('./factories/cordova_ready.coffee')

app.factory factories





