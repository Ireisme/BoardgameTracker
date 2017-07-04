var angular = require('angular');
var app = angular.module('BoardgameTracker');

app.controller('GameCtrl', require('./GameCtrl.js.coffee'));
app.controller('GamesAddCtrl', require('./GamesAddCtrl.js.coffee'));
app.controller('GamesAllCtrl', require('./GamesAllCtrl.js.coffee'));
app.controller('HomeCtrl', require('./HomeCtrl.js.coffee'));
app.controller('LoginCtrl', require('./LoginCtrl.js.coffee'));
app.controller('PlayerCtrl', require('./PlayerCtrl.js.coffee'));
app.controller('PlayersAddCtrl', require('./PlayersAddCtrl.js.coffee'));
app.controller('PlayersAllCtrl', require('./PlayersAllCtrl.js.coffee'));
app.controller('SessionsAddCtrl', require('./SessionsAddCtrl.js.coffee'));
app.controller('SessionsAllCtrl', require('./SessionsAllCtrl.js.coffee'));
