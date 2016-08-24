var angular = require('angular');
var app = angular.module('BoardgameTracker');

app.factory('GamesService', require('./GamesService.js.coffee'));
app.factory('PlayersService', require('./PlayersService.js.coffee'));
app.factory('SessionsService', require('./SessionsService.js.coffee'));
app.factory('PlayerStatisticsService', require('./PlayerStatisticsService.js.coffee'));
