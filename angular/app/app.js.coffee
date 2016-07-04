require('angular-material')
require('angular-ui-router')
require('angular-cookie')
require('ng-token-auth')

angular = require('angular')
config = require('./config.js.coffee')
run = require('./run.js.coffee')

app = angular.module('BoardgameTracker', [
  'ngMaterial',
  'ui.router',
  'ng-token-auth'
])

require('./controllers')
require('./services')

app.config(config)
app.run(run)
