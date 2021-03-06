module.exports = ($scope, $stateParams, GamesService, TitleService) ->
  GamesService.Get($stateParams.id)
    .then (data) ->
      $scope.game = data
      TitleService.Title = $scope.game.name

      best_player = $scope.game.best_player
      worst_player = $scope.game.worst_player
      $scope.game.best_player.percentage = Math.round(best_player.percent * 100) if best_player?
      $scope.game.worst_player.percentage = Math.round(worst_player.percent * 100) if worst_player?
      return

module.exports.$inject = ['$scope', '$stateParams', 'GamesService', 'TitleService']
