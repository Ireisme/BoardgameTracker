angular.module('BoardgameTracker')
.controller 'GameCtrl', ['$scope', '$stateParams', 'GamesService', ($scope, $stateParams, GamesService) ->
  GamesService.Get($stateParams.id)
    .then (data) -> 
      $scope.game = data
      return
  ]
