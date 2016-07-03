angular.module('BoardgameTracker')
.controller 'PlayerCtrl', ['$scope', '$stateParams', 'PlayersService', ($scope, $stateParams, PlayersService) ->
  PlayersService.Get($stateParams.id)
    .then (data) -> 
      $scope.player = data
      return
  ]
