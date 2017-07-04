module.exports = ($scope, $stateParams, PlayersService, PlayerStatisticsService, TitleService) ->
  PlayersService.Get($stateParams.id)
    .then (data) ->
      $scope.player = data
      TitleService.Title = $scope.player.name
      return
    .then ->
      PlayerStatisticsService.Get($stateParams.id)
        .then (data) ->
          $scope.statistics = data

          to_percent = (decimal) -> (Math.round(decimal * 1000) / 10) if decimal?
          best_game = $scope.statistics?.best_game
          worst_game = $scope.statistics?.worst_game
          overall_percent = $scope.statistics.win_rate
          $scope.statistics.best_game.percentage = to_percent(best_game?.win_percent)
          $scope.statistics.worst_game.percentage = to_percent(worst_game?.win_percent)
          $scope.statistics.overall_percentage = to_percent(overall_percent)

          return

module.exports.$inject = ['$scope', '$stateParams', 'PlayersService', 'PlayerStatisticsService', 'TitleService']
