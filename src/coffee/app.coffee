'use strict'
#constants
MainCtrl = require('./controllers/main_ctrl.coffee')

app = angular.module 'mampfApp', ['onsen.directives', 'ngTouch']

app.controller 'MainCtrl', MainCtrl



