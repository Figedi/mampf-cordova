'use strict'
#constants
MainCtrl = require('./controllers/main_ctrl.coffee')

app = angular.module 'mampfApp', ['onsen.directives']

app.controller 'MainCtrl', MainCtrl



