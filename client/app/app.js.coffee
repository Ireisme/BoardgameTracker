require('angular-material')
require('angular-ui-router')
require('angular-cookie')
require('ng-token-auth')

require('../index.html')

angular = require('angular')

app = angular.module('BoardgameTracker', [
  'ngMaterial',
  'ui.router',
  'ng-token-auth',
])

configuration = require('json!./config/configuration.json')
app.constant('SERVER_URI', configuration.SERVER_URI)

config = require('./config.js.coffee')
run = require('./run.js.coffee')

require('./controllers')
require('./services')

app.config(config)
app.run(run)
