angular.module('BoardgameTracker')
.controller 'PlayersAllCtrl', ['$scope', 'PlayersService', ($scope, PlayersService) ->
  PlayersService.GetAll()
    .then (data) -> 
      $scope.players = data
      return
  ]
