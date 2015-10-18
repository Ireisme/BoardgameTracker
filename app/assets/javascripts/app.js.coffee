app = angular.module('BoardgameTracker', [
  'templates',
  'ngMaterial',
  'ui.router'
]).config([
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state 'home',
      url: '/home'
      templateUrl: 'home.html'
      controller: 'HomeCtrl'
    .state 'home.games',
      url: '/games'
      abstract: true,
      template: '<ui-view></ui-view>'
    .state 'home.games.all',
      url: '/all'
      templateUrl: 'games-all.html'
      controller: 'GamesAllCtrl'
    .state 'home.games.add',
      url: '/add'
      templateUrl: 'games-add.html'
      controller: 'GamesAddCtrl'
    .state 'home.games.view',
      url: '/{id}'
      templateUrl: 'game.html'
      controller: 'GameCtrl'
    .state 'home.players.all',
      url: '/players'
      templateUrl: 'players.html'
      controller: 'PlayersCtrl'

    $urlRouterProvider.otherwise 'home'
    return
])