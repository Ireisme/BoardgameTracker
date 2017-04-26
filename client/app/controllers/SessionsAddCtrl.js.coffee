module.exports = ($scope, $state, GamesService, PlayersService, SessionsService, dateFilter) ->
  $scope.session = {
    played: new Date
    session_players: []
    newPlayer: null
  }

  GamesService.GetAll()
    .then (data) ->
      $scope.games = data
      return

  PlayersService.GetAll()
    .then (data) ->
      $scope.players = data
      return

  $scope.availablePlayers = () ->
    inUse = _.pluck($scope.session.session_players, "player_id")
    return _.filter($scope.players, (player) ->
      return !_.contains(inUse, player.id))

  $scope.playerSelected = () ->
    player = angular.copy($scope.session.newPlayer);
    if (player && player.id > 0)
      $scope.session.session_players.push(
        {
          player_id: player.id,
          player_name: player.name
        });
      $scope.session.newPlayer = null;
    return

  $scope.removePlayer = (index) ->
    $scope.session.session_players.splice index, 1
    return

  $scope.saveSession = () ->
    SessionsService.Add($scope.session)
      .then (data) ->
        $state.go('home.sessions.all')
        return
      return

  return

module.exports = ["$scope", "$state", "GamesService", "PlayersService", "SessionsService", "dateFilter"]
