require('angular-material')
require('angular-ui-router')
require('AngularDevise')

angular = require('angular')
config = require('./config.js.coffee')
run = require('./run.js.coffee')

app = angular.module('BoardgameTracker', [
  'ngMaterial',
  'ui.router',
  'Devise'
])

require('./controllers')
require('./services')

app.config(config)
app.run(run)
