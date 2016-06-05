angular.module('BoardgameTracker')
.controller 'GameCtrl', ['$scope', '$stateParams', 'GamesService', ($scope, $stateParams, GamesService) ->
  GamesService.Get($stateParams.id)
    .then (data) -> 
      $scope.game = data
      $scope.game.best_player.percentage = Math.round $scope.game.best_player.percent * 100
      $scope.game.worst_player.percentage = Math.round $scope.game.worst_player.percent * 100
      return
  ]
