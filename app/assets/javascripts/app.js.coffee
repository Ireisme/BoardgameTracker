app = angular.module('BoardgameTracker', [
  'templates',
  'ngMaterial',
  'ui.router',
  'Devise'
]).config([
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state 'login',
      url: '/login'
      templateUrl: 'login.html'
      controller: 'LoginCtrl'
      title: 'Login'
    .state 'home',
      url: '/home'
      templateUrl: 'home.html'
      controller: 'HomeCtrl'
      title: 'Home'
    .state 'home.games',
      url: '/games'
      abstract: true,
      template: '<ui-view></ui-view>'
      title: 'Games'
    .state 'home.games.all',
      url: '/all'
      templateUrl: 'games-all.html'
      controller: 'GamesAllCtrl'
      title: 'Games'
    .state 'home.games.add',
      url: '/add'
      templateUrl: 'games-add.html'
      controller: 'GamesAddCtrl'
      title: 'Add a Game'
    .state 'home.games.view',
      url: '/{id}'
      templateUrl: 'game.html'
      controller: 'GameCtrl'
      title: '{{ game.name }}'
      resolve: 
        game: ($stateParams, GamesService) ->
          return GamesService.Get($stateParams.id)
    .state 'home.players',
      url: '/players'
      abstract: true,
      template: '<ui-view></ui-view>'
      title: 'Players'
    .state 'home.players.all',
      url: '/all'
      templateUrl: 'players-all.html'
      controller: 'PlayersAllCtrl'
      title: 'Players'
    .state 'home.players.add',
      url: '/add'
      templateUrl: 'players-add.html'
      controller: 'PlayersAddCtrl'
      title: 'Add Player'
    .state 'home.players.view',
      url: '/{id}'
      templateUrl: 'player.html'
      controller: 'PlayerCtrl'
      title: '{{ player.name }}'
      resolve: 
        game: ($stateParams, PlayersService) ->
          return PlayersService.Get($stateParams.id)

    $urlRouterProvider.otherwise 'home'
    return
]).run([
  '$rootScope'
  '$state'
  'Auth'
  ($rootScope, $state, Auth) ->
    $rootScope.$on '$stateChangeStart', (evt, next, nextParams, current, currentParams) ->
      params = undefined
      if next.name != 'login'
        console.log 'app.js.coffee'
        Auth.currentUser({ interceptAuth: false }).then ((user) ->
          console.log user
        ),
        (error) ->
          console.log 'error'
          evt.preventDefault()
          params = JSON.stringify(nextParams)
          $state.go 'login',
            redirectTo: next.name
            redirectParams: params
          return

      return
])