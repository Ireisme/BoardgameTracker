module.exports = ($scope, $stateParams, PlayersService, PlayerStatisticsService) ->
  PlayersService.Get($stateParams.id)
    .then (data) ->
      $scope.player = data
      return
    .then ->
      PlayerStatisticsService.Get($stateParams.id)
        .then (data) ->
          $scope.player.statistics = data

          to_percent = (decimal) -> (Math.round(decimal * 1000) / 10) if decimal?
          best_game = $scope.player?.statistics?.best_game
          worst_game = $scope.player?.statistics?.worst_game
          overall_percent = $scope.player?.statistics.win_rate
          $scope.player.statistics.best_game.percentage = to_percent(best_game?.win_percent)
          $scope.player.statistics.worst_game.percentage = to_percent(worst_game?.win_percent)
          $scope.player.statistics.overall_percentage = to_percent(overall_percent)
          
          return

module.exports.$inject = ['$scope', '$stateParams', 'PlayersService', 'PlayerStatisticsService']
