angular.module('BoardgameTracker')
.controller 'GamesAllCtrl', ['$scope', 'GamesService', ($scope, GamesService) ->
  GamesService.GetAll()
    .then (data) -> 
      $scope.games = data
      return
  ]
