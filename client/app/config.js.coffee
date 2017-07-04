module.exports = ($stateProvider, $urlRouterProvider, $authProvider) ->

  $authProvider.configure({
      apiUrl: 'https://candyce-wins.herokuapp.com/',
      storage: 'localStorage'
  })

  $stateProvider
    .state 'login',
      url: '/login'
      template: require('./templates/login.html')
      controller: 'LoginCtrl'
      title: 'Login'
    .state 'home',
      url: '/home'
      template: require('./templates/home.html')
      controller: 'HomeCtrl'
      title: 'Home'
    .state 'home.games',
      url: '/games'
      abstract: true,
      template: '<ui-view></ui-view>'
      title: 'Games'
    .state 'home.games.all',
      url: '/all'
      template: require('./templates/games-all.html')
      controller: 'GamesAllCtrl'
      title: 'Games'
    .state 'home.games.add',
      url: '/add'
      template: require('./templates/games-add.html')
      controller: 'GamesAddCtrl'
      title: 'Add a Game'
    .state 'home.games.view',
      url: '/{id}'
      template: require('./templates/game.html')
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
      template: require('./templates/players-all.html')
      controller: 'PlayersAllCtrl'
      title: 'Players'
    .state 'home.players.add',
      url: '/add'
      template: require('./templates/players-add.html')
      controller: 'PlayersAddCtrl'
      title: 'Add Player'
    .state 'home.players.view',
      url: '/{id}'
      template: require('./templates/player.html')
      controller: 'PlayerCtrl'
      title: '{{ player.name }}'
      resolve:
        game: ($stateParams, PlayersService) ->
          return PlayersService.Get($stateParams.id)
    .state 'home.sessions',
      url: '/sessions'
      abstract: true,
      template: '<ui-view></ui-view>'
      title: 'Sessions'
    .state 'home.sessions.all',
      url: '/all'
      template: require('./templates/sessions-all.html')
      controller: 'SessionsAllCtrl'
      title: 'Sessions'
    .state 'home.sessions.add',
      url: '/add'
      template: require('./templates/sessions-add.html')
      controller: 'SessionsAddCtrl'
      title: 'Add Session'

    $urlRouterProvider.otherwise 'home'
    return

module.exports.$inject = ['$stateProvider', '$urlRouterProvider', '$authProvider']
